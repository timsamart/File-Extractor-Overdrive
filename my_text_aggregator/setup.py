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
