# Create main project folder
New-Item -ItemType Directory -Path .\my_text_aggregator

# Create publish_to_pypi.ps1 for PyPI publishing
@"
# Publish Python package to PyPI
# Make sure you have already installed twine via pip install twine

# Remove any existing distributions
Remove-Item -Force -Recurse .\dist\*

# Create new distribution packages
python setup.py sdist bdist_wheel

# Upload to PyPI
twine upload dist/*
"@ | Set-Content .\my_text_aggregator\publish_to_pypi.ps1

Write-Host "Done. You can now navigate to .\my_text_aggregator and run publish_to_pypi.ps1 to publish your package."
