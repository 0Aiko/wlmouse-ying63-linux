# wlmouse-ying63-linux
This repository provides a simple `udev` rule to grant your browser access to the WLmouse Ying63 so you can use the website software under Linux.

---

## ⚙️ Instructions

### 1. Find Vendor ID and Product ID (most likely they will be the same as mine, but if something doesn’t work it’s worth checking)

Open a terminal and run:

```bash
lsusb
```
![image](https://github.com/user-attachments/assets/31ffdb0a-60ee-49ca-87e4-7b5a62ceecda)
### 2. Copy the rules file to rules.d directory:

And make sure the VID and PID are correct
```bash
sudo cp 99-wlmouse.rules /etc/udev/rules.d/99-wlmouse.rules
sudo nano /etc/udev/rules.d/99-wlmouse.rules
```
![image](https://github.com/user-attachments/assets/1bb1b206-0959-45b1-8a19-8f61b6ebc3ac)


### 3. Apply the rules:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

## After completing the steps, your browser software should work!

![image](https://github.com/user-attachments/assets/22417153-272a-4846-93cf-3eaeb0179c29)

## If u lazy here is bash script for this:

Download the `wlmouse-udev.sh`

Then run:
```bash
chmod +x wlmouse-udev.sh
./wlmouse-udev.sh
```


