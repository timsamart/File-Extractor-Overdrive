# Create main project folder
New-Item -ItemType Directory -Path .\my_text_aggregator

# Create Python package sub-folder
New-Item -ItemType Directory -Path .\my_text_aggregator\my_text_aggregator

# Create setup.py
@"
from setuptools import setup, find_packages

setup(
    name='my_text_aggregator',
    version='0.1',
    packages=find_packages(),
    install_requires=[
        'PyPDF2',
        'pdfplumber',
        'pdf2image',
        'pytesseract',
        'python-docx',
        'odfpy'
    ],
    entry_points={
        'console_scripts': [
            'aggregate_texts=my_text_aggregator.aggregator:main',
        ],
    },
)
"@ | Set-Content .\my_text_aggregator\setup.py

# Create README.md
@"
# My Text Aggregator

This package aggregates text from various file types in a folder.
"@ | Set-Content .\my_text_aggregator\README.md

# Create __init__.py
New-Item -ItemType File -Path .\my_text_aggregator\my_text_aggregator\__init__.py

# Create aggregator.py with your advanced code
@"
import os
import PyPDF2
import pdfplumber
from pdf2image import convert_from_path
import pytesseract
from docx import Document
from odf import text, teletype
from odf.opendocument import load

def read_odt(file_path):
    textdoc = load(file_path)
    alltexts = textdoc.getElementsByType(text.P)
    odt_text = ""
    for t in alltexts:
        odt_text += teletype.extractText(t)
    return odt_text


def read_pdf(file_path):
    with pdfplumber.open(file_path) as pdf:
        text = ''
        for page in pdf.pages:
            text += page.extract_text()
        return text

def ocr_pdf(file_path):
    text = ''
    images = convert_from_path(file_path)
    for i in images:
        text += pytesseract.image_to_string(i)
    return text

def read_txt(file_path):
    with open(file_path, 'r') as file:
        return file.read()

def read_md(file_path):
    return read_txt(file_path)

def read_docx(file_path):
    doc = Document(file_path)
    return ' '.join([paragraph.text for paragraph in doc.paragraphs])

def aggregate_files(folder_path):
    aggregated_text = ''
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        
        if filename.endswith('.pdf'):
            aggregated_text += read_pdf(file_path)
            aggregated_text += ocr_pdf(file_path)
        elif filename.endswith('.odt'):
            aggregated_text += read_odt(file_path)
        elif filename.endswith('.txt'):
            aggregated_text += read_txt(file_path)
        elif filename.endswith('.md'):
            aggregated_text += read_md(file_path)
        elif filename.endswith('.docx'):
            aggregated_text += read_docx(file_path)
    
    with open('aggregated_output.txt', 'w') as out_file:
        out_file.write(aggregated_text)

if __name__ == '__main__':
    aggregate_files('./your_folder_here')
"@ | Set-Content .\my_text_aggregator\my_text_aggregator\aggregator.py

# Create requirements.txt file
@"
PyPDF2
pdfplumber
pdf2image
pytesseract
python-docx
odfpy
"@ | Set-Content .\my_text_aggregator\requirements.txt



