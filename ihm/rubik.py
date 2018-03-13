from tkinter import *
import serial


class Window(Tk):
    faces = ["U", "L", "F", "R", "B", "D"]

    def __init__(self):
        Tk.__init__(self)
        self.title("rubik")
        self.resizable(False, False)
        self.cube = Frame(self)
        self.facelets = [[Facelet(self.cube, f, n) for n in range(9)] for f in range(6)]
        self.cube.pack()
        self.control = Frame(self)
        self.send = Button(self.control, text="send", width=10, height=2, command=self.on_send_click)
        self.send.pack()
        self.control.pack()
        self.mainloop()

    @staticmethod
    def serial_write(ser, s):
        ser.write((s+"\n").encode())

    @staticmethod
    def serial_read(ser):
        return ser.readline().decode().rstrip()

    def on_send_click(self):
        port = "COM3"
        s = self.cube_state_to_string()
        self.clipboard_clear()
        self.clipboard_append(s)
        try:
            with serial.Serial(port, timeout=1) as ser:
                Window.serial_write(ser, s)
                print("<<"+s)
                print(">>"+Window.serial_read(ser))
        except serial.serialutil.SerialException:
            print("cannot use port "+port)

    def cube_state_to_string(self):
        s = ""
        for f in range(6):
            for n in range(9):
                s += Window.faces[self.facelets[f][n].color]
        return s


class Facelet:
    colors = ["white", "red", "blue", "orange", "green", "yellow"]

    def __init__(self, parent, f, n):
        self.frame = Frame(parent, width=50, height=50)
        self.color = f
        self.frame.pack_propagate(0)  # pour que les boutons prennent tout le carré sans le déformer
        self.button = Button(self.frame, width=100, height=100, command=self.on_facelet_click)
        self.button.configure(bg=Facelet.colors[self.color])
        self.button.pack()
        r = 0 if f == 0 else 6 if f == 5 else 3
        c = 0 if f == 1 else 6 if f == 3 else 9 if f == 4 else 3
        r += n//3
        c += n % 3
        self.frame.grid(row=r, column=c)

    def on_facelet_click(self):
        self.color = (self.color+1) % 6
        self.button.configure(bg=Facelet.colors[self.color])


if __name__ == "__main__":
    Window()
