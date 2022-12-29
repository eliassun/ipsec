"""
utils.py from https://github.com/eliassun/ipsec
The log utils.py provides the wrapper of a logger
Created by Elias Sun
date: Dec 28, 2022
"""

import sys
import time
import logging
import logging.handlers

LOG_MAX_LEN = 2500000  # 2.5M bytes
LOG_ROTATION_CNT = 4
LOG_DEFAULT_NAME = "apedege.log"
LOG_OUTPUT_NAME = "aped"
LOG_DEFAULT_LEVEL = logging.DEBUG
LOG_DEFAULT_FILE_NAME = "/var/log/pedege.log"


class Logger:

    def __init__(self, level=LOG_DEFAULT_LEVEL, log_name=LOG_DEFAULT_NAME):
        self._level = level
        self._log_name = log_name
        self._log = logging.getLogger(self._log_name)
        self._log_file = LOG_DEFAULT_FILE_NAME
        try:
            handler = logging.handlers.RotatingFileHandler(log_name, maxBytes=LOG_MAX_LEN,
                                                           backupCount=LOG_ROTATION_CNT, encoding='UTF-8')
        except Exception as err:
            print("Failed to start the log module: ", LOG_DEFAULT_NAME, err)
            return None

        else:
            self._log.progagte = False
            logging.basicConfig(level=logging.INFO, filename=LOG_DEFAULT_FILE_NAME, datefmt="%m/%d/%Y %I:%M:%S %p %Z",
                                format="[%(asctime)s %(process)d %(thread)d %(levelname)1s %(module)s %(funcName)s %(lineno)d]  %(message)s")
            stream_h = logging.StreamHandler(sys.stdout)
            stream_h.setLevel(self._level)
            self._log.addHandler(stream_h)
            self._log.addHandler(handler)
            self._log.setLevel(self._level)
            logging.Formatter.converter = time.gmtime

    def log(self):
        """ Init log """
        return self._log

    @property
    def level(self):
        return self._level

    @level.setter
    def level(self, level=LOG_DEFAULT_LEVEL):
        self._level = level
