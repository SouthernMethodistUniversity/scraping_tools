import tempfile, shutil
from browserinstance import BrowserInstance

tmp_dir = tempfile.mktemp()
with BrowserInstance(tor=False, save_directory=tmp_dir, random_pages=True, test=True) as browser:
  for i in range(1, 20):
    url = "https://www.amazon.com/s?k=Handmade+Rings&i=handmade&page={}&_encoding=UTF8".format(i)
    browser.get_url(url)
shutil.rmtree(tmp_dir)

