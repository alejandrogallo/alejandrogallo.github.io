+++
title = "WLAN QRcode generator"
author = ["Alejandro Gallo"]
date = 2022-10-09T00:00:00+02:00
tags = ["tool"]
draft = false
+++

<script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

<center>
  <div id="qrcode";></div>
  <input type="text" id="ssid" placeholder="Network Name" oninput="generate_qrcode()">
  <br>
  <input type="password" id="pass" placeholder="Password" oninput="generate_qrcode()">
</center>

<script>
function generate_qrcode() {
    let ssid = document.getElementById("ssid").value,
        pass = document.getElementById("pass").value,
        qrcode = document.getElementById("qrcode");

    while (qrcode.lastChild) {
        qrcode.removeChild(qrcode.lastChild);
    }

    new QRCode(qrcode,
               `WIFI:S:${ssid};T:WPA;P:${pass};;`);
}
window.addEventListener("load", generate_qrcode);
</script>


## How it works {#how-it-works}

Many people often ask me how I generated the QRCode for my Wireless
network, so I decided to write this for them.
Nowadays it is quite often that the routers come with the QRcode already
baked in or they provide ways of generating the QRcode through their
admin webiste. However not everyone is able to easily access to the router
admin page or maybe some other websites on the internet are full of ads or are
simply too slow.
That is why I provide here this minimal functionality with an explanation.

The above QRCode simply encodes a special string that the application that
is scanning understands. Let us suppose that your wireless network
is called **Homer** and the password is **123456789**, then the QRCode simply
encodes the following text

```text
WIFI:S:Homer;T:WPA;P:123456789;;
```

Therefore, this website is just a helping tool for you to convert
this piece of text into an image, that your camera app can then read
and maybe it recognises that the text starts with the word `WIFI`
and logs you in automatically.


## References {#references}

-   The code simply uses the great library by [@davidshimjs](https://github.com/davidshimjs)
    [qrcodejs](https://github.com/davidshimjs/qrcodejs).
