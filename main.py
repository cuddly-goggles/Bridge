print("You are now in Python")
import youtube_dl
import json
class YoutubeDL:
    ydl=0
    def __init__(self):
        self.ydl = youtube_dl.YoutubeDL({'dump_single_json': True, 'nocheckcertificate': True})

    def extractInfo(self, url):
        
        try:
            result = self.ydl.extract_info(url, download=False)
            jsonResult = json.dumps(result)
            return jsonResult
        except:
            pass

    '''def extractInfo(self, url):
        with self.ydl:
            self.ydl.download([url])
        return "hi"'''
