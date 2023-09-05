import os
import argparse

import PyPDF2
import pdfplumber
from pdf2image import convert_from_path
import pytesseract
from docx import Document
from odf import text, teletype
from odf.opendocument import load


def read_odt(file_path):
    print(f"Reading ODT file {file_path}...")
    textdoc = load(file_path)
    alltexts = textdoc.getElementsByType(text.P)
    odt_text = ""
    for t in alltexts:
        odt_text += teletype.extractText(t)
    print(f"Finished reading ODT file {file_path}.")
    return odt_text


def read_pdf(file_path):
    print(f"Reading PDF file {file_path}...")
    with pdfplumber.open(file_path) as pdf:
        text = ""
        for page in pdf.pages:
            text += page.extract_text()
    print(f"Finished reading PDF file {file_path}.")
    return text


def ocr_pdf(file_path):
    print(f"OCR-ing PDF file {file_path}...")
    text = ""
    images = convert_from_path(file_path)
    for i in images:
        text += pytesseract.image_to_string(i)
    print(f"Finished OCR-ing PDF file {file_path}.")
    return text


def read_txt(file_path):
    print(f"Reading TXT file {file_path}...")
    with open(file_path, "r") as file:
        content = file.read()
    print(f"Finished reading TXT file {file_path}.")
    return content


def read_md(file_path):
    print(f"Reading MD file {file_path}...")
    content = read_txt(file_path)
    print(f"Finished reading MD file {file_path}.")
    return content


def read_docx(file_path):
    print(f"Reading DOCX file {file_path}...")
    doc = Document(file_path)
    content = " ".join([paragraph.text for paragraph in doc.paragraphs])
    print(f"Finished reading DOCX file {file_path}.")
    return content


def aggregate_files(folder_path):
    files_list = os.listdir(folder_path)
    total_files = len(files_list)

    # Open the output file in append mode
    with open("aggregated_output.txt", "a") as out_file:
        for index, filename in enumerate(files_list):
            file_path = os.path.join(folder_path, filename)
            remaining_files = total_files - (index + 1)

            print(f"File: {filename}")
            print(f"File type: {filename.split('.')[-1]}")
            print(f"Starting aggregation of {filename}...")
            print(f"Files remaining: {remaining_files}")
            print(f"Total files in pipeline: {total_files}")

            text_to_add = ""

            if filename.endswith(".pdf"):
                text_to_add = read_pdf(file_path) + ocr_pdf(file_path)
            elif filename.endswith(".odt"):
                text_to_add = read_odt(file_path)
            elif filename.endswith(".txt"):
                text_to_add = read_txt(file_path)
            elif filename.endswith(".md"):
                text_to_add = read_md(file_path)
            elif filename.endswith(".docx"):
                text_to_add = read_docx(file_path)

            # Append the text directly to the file
            out_file.write(text_to_add)

            print(f"Finished aggregation of {filename}")

        print("Aggregated output saved to 'aggregated_output.txt'.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Aggregate text from various file types in a folder."
    )
    parser.add_argument(
        "folder_path",
        type=str,
        help="The path of the folder containing the files to aggregate",
    )

    args = parser.parse_args()
    aggregate_files(args.folder_path)
