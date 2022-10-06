#!/bin/bash
set -e



# install chrome
wget -nc https://dl-ssl.google.com/linux/linux_signing_key.pub 
cat linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/linux_signing_key.gpg  >/dev/null 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/chrome.list' 
sudo apt update 
sudo apt install google-chrome-stable 


# pyodide build and test
pip install pytest 
pip install pyodide-build pytest-pyodide 
# install chromedriver stuff for selenium to control chrome
pip install selenium webdriver-manager 
pip install chromedriver-binary-auto
# make sure chromedriver is on path
export PATH=$PATH:`chromedriver-path`
# get pyodide to tests/pyodide
# run the tests
cd tests
pytest . --dist-dir ./pyodide --rt chrome -v 