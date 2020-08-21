import os
from lxml import etree
import logging
import threading
 
BASEPATH = '/home/ubuntu/data/input/'
LOGGING_FILE = '/home/ubuntu/data/log/bad_xml.log'

logger = logging.getLogger('not_good')
logger.setLevel(logging.DEBUG)
ch = logging.StreamHandler()
fh = logging.FileHandler(LOGGING_FILE)
logger.addHandler(fh)
logger.addHandler(ch)

def try_xml(my_f):
    try:
        tree = etree.parse(my_f)
    except Exception as e:
        logger.info(my_f)
 
# r=root, d=directories, f=files
for r, d, f in os.walk(BASEPATH):
        for file in f:
            if '.kml' in file or '.dae' in file:
                my_f = os.path.join(r, file)
                x = threading.Thread(target=try_xml, args=(my_f,))
                x.daemon = True
                x.start()
