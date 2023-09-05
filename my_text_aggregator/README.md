# File-Extractor-Overdrive

## Description

The File-Extractor-Overdrive is a comprehensive text aggregator from multiple file types including PDF, ODT, TXT, MD, and DOCX. The script reads these files from a specified folder and combines their text content into a single output file. This is particularly useful for data analytics, document summarization, and easy archival. The script also incorporates Optical Character Recognition (OCR) for PDFs, extracting text from images within the PDFs as well.

## Requirements

- Python 3.x
- PyPDF2
- pdfplumber
- pdf2image
- pytesseract
- python-docx
- odfpy

To install these, run `install_requirements.ps1` script.

## File Structure

```plaintext
E:\repome\File-Extractor-Overdrive
├── .vscode
│   └── settings.json
├── my_text_aggregator
│   ├── my_text_aggregator
│   │   ├── aggregator.py
│   │   └── __init__.py
│   ├── debug.log
│   ├── README.md
│   ├── requirements.txt
│   └── setup.py
├── create_publishing_script.ps1
├── debug.log
├── init.ps1
└── install_requirements.ps1
```

## How to Use

1. Clone the repository.
2. Navigate to the project folder and run `install_requirements.ps1` to install the necessary dependencies.
3. Use the following command to execute the aggregator:
   ```
   python aggregator.py <folder_path>
   ```
   Replace `<folder_path>` with the path of the folder containing the files to be aggregated.

### Functionality Breakdown

- `read_pdf(file_path)`: Reads text from PDF files.
- `ocr_pdf(file_path)`: Extracts text from images within PDFs.
- `read_odt(file_path)`: Reads text from ODT files.
- `read_txt(file_path)`: Reads text from TXT files.
- `read_md(file_path)`: Reads text from Markdown files.
- `read_docx(file_path)`: Reads text from DOCX files.
- `aggregate_files(folder_path)`: Orchestrates the text extraction and aggregation from the given folder.

## Contributors

- Created and maintained by Timmy (Head of Concepts and Innovation)

## License

This project is licensed under the MIT License.

## Disclaimers

- This tool assumes that the OCR can perfectly read all types of fonts and backgrounds. Depending on the quality of the PDF, results may vary.
- It adheres to the principles of GDPR and ISO standards for data handling.
