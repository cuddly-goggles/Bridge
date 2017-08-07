
import youtube_dl
import json
from contextlib import suppress
class YoutubeDL:
    
    def __init__(self):
        self.ydl = youtube_dl.YoutubeDL({'dump_single_json': True, 'nocheckcertificate': True})

    def generate_response(self, is_error, error_msg, data):
        response = {'is_error': is_error, 'error_msg': error_msg, 'data': data}
        r = json.dumps(response)
        return str(r)


    def extract_info(self, url):
        with suppress(Exception):
            try:
                result = self.ydl.extract_info(url, download=False)
                json_result = json.dumps(result)
                return self.generate_response(False, '0', json_result)
            except Exception as error:
                return self.generate_response(True, str(error), '0')


