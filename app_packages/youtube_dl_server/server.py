

from app import app





def main():
    app.run('0.0.0.0', 9191, processes=5)


main()
