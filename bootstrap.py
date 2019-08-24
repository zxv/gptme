import io
import os
from google.colab import auth
from googleapiclient.discovery import build
from apiclient.http import MediaIoBaseDownload
from tqdm.auto import tqdm

NUMBER = 800000
MODEL = "grover_mega_owt_fix"
MODEL_TYPE = "mega"
MODEL_PATH = "/content/grover/models"


def make_path():
    model_dir = os.path.join(MODEL_PATH, MODEL_TYPE)
    if not os.path.exists(model_dir):
        os.makedirs(model_dir)


def weight_files():
    local_filenames = [".data-00000-of-00001", ".index", ".meta"]
    local_file_ids = [
        "1t1B5JfjolytwSSUAGOZCnstVlaL2Bg25",
        "1kojGap2kXzkJBWtwIZtOXgeV3IWnNMtO",
        "1FITtxBwJsagKfaLz9tgsguHbbdMCyeQw",
    ]
    for ext, id_ in zip(local_filenames, local_file_ids):
        ext = str(NUMBER) + ext
        filename = "%s/%s/model.ckpt.%s" % (MODEL_PATH, MODEL_TYPE, ext)
        yield filename, id_


def get_file(filename, id_):
    auth.authenticate_user()
    drive_service = build("drive", "v3")

    request = drive_service.files().get_media(fileId=id_)
    with open(filename, "wb") as f:
        downloader = MediaIoBaseDownload(f, request, chunksize=100 * 1024 * 1024)
        done = False
        pbar = tqdm(total=100, desc="%s" % ext)
        progress = 0
        while done is False:
            status, done = downloader.next_chunk()
            new_progress = int(status.progress() * 100)
            pbar.update(new_progress - progress)
            progress = new_progress

        pbar.close()
    print("Downloaded %s" % filename)


def get_weights():
    for filename, id_ in weight_files():
        get_file(filename, id_)


if __name__ == "__main__":
    make_path()
    get_weights()
