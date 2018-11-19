## STATE
KaraDio32 in dev state: Release 1.5 R0 Stable<br/>
<br/>
<br/>
Works on any esp32 board.<br/><br/>
See the feature on https://hackaday.io/project/11570-wifi-webradio-with-esp8266-and-vs1053 <br/>
The esp32 adds the output on the internal dac or with i2s to an external dac<br/>
but only mp3 stations can be played.<br/>
Adding a vs1053 board, all stations can be played.<br/>
Compatible with esp8266 KaRadio addons.<br/>
Uart or telnet commands: http://karadio.karawin.fr/Interface.txt <br/>
<br/>
## Added features
Work with i2s, internal DAC or a vs1053<br/>
Output mode set in Setting panel on web page of KaraDio32:<br/>
- I2S for connection to ac external DAC<br/>
- I2SMERUS to connect a merus amplifier<br/>
- DAC to use the built in DAC of the esp32<br/>
- PDM to output a PDM (Pulse Density Modulation) stream<br/>
- VS1053 to connect to a vs1053 board.<br/>
<br/>
mDNS support.<br/>
Latin, Cyrillic and Greek support.<br/>
24 types of lcd or oled  B/W or Color supported.<br/>
Two max  rotary encoders. One for volume priority, one for station change priority.<br/>
Two max set of 3 buttons. One for volume priority, one for station change priority.<br/>
ADC keyboard with 6 buttons.<br/>
NEC ir remote control.<br/>
Programmable lcd off timer<br/>
Date format DD:MM:YYYY or MM:DD:YYYY .<br/>
Remote IR support integrated. Nec protocol only.<br/>
Rotary encoder and set of buttons support integrated. Common functions: play/stop, volume, station change, date time display.<br/>
<br/>

## Configure the hardware and IR codes
If the default configuration doesn't fit your needs, you can externally configure the software to fit your hardware and peripherals to suit your needs.<br/>
The configuration file is to be flashed only one time. After that, the standard delivery will become compatible with your hardware gpio use and peripherals configuration. A future standard OTA will automatically works.<br/>
See http://karadio.karawin.fr/HardwareConfig.txt <br/>

## Build your own
To build your own release, you must install the idf https://github.com/espressif/esp-idf and the toolchain.
```
To flash all build output, run 'make flash' or:
python /home/yourhome/esp/esp-idf/components/esptool_py/esptool/esptool.py --chip esp32 --port com5 --baud 460800 --before default_reset --after hard_reset write_flash -u --flash_mode dio --flash_freq 40m --flash_size detect 0x1000 /home/yourhome/esp/Ka-Radio32/build/bootloader/bootloader.bin 0x10000 /home/yourhome/esp/Ka-Radio32/build/KaRadio32.bin 0x8000 /home/yourhome/esp/Ka-Radio32/build/partitions.bin
```
### GPIO Definition 
The default configuration is given below. It includes an encoder, an IR remote and a LCD or OLED.<br/>
See the file main/include/gpio.h and main/include/addon.h <br/>
```
//-------------------------------//
// Define GPIO used in KaRadio32 //
//-------------------------------//
// Compatible ESP32 ADB
// https://www.tindie.com/products/microwavemont/esp32-audio-developing-board-esp32-adb/
// Default value, can be superseeded by the hardware partition.

// Must be HSPI or VSPI

#define KSPI VSPI_HOST

// KSPI pins of the SPI bus
//-------------------------
#define PIN_NUM_MISO GPIO_NUM_19 	// Master Input, Slave Output
#define PIN_NUM_MOSI GPIO_NUM_23	// Master Output, Slave Input   Named Data or SDA or D1 for oled
#define PIN_NUM_CLK  GPIO_NUM_18 	// Master clock  Named SCL or SCK or D0 for oled

// status led if any.
//------------------- 
// Set the right one with command sys.led
// GPIO can be changed with command sys.ledgpio("x")
#define GPIO_LED	GPIO_NUM_4		// Flashing led or Playing led

// gpio of the vs1053
//-------------------
#define PIN_NUM_XCS  GPIO_NUM_32
#define PIN_NUM_RST  GPIO_NUM_12 
#define PIN_NUM_XDCS GPIO_NUM_33
#define PIN_NUM_DREQ GPIO_NUM_34
// + KSPI pins

// Encoder knob
//-------------
#define PIN_ENC0_A   GPIO_NUM_16	//16	// 255 if encoder not used
#define PIN_ENC0_B   GPIO_NUM_17	//17	// DT
#define PIN_ENC0_BTN GPIO_NUM_5		//5// SW
#define PIN_ENC1_A   GPIO_NONE		// 255 if encoder not used
#define PIN_ENC1_B   GPIO_NONE		// DT
#define PIN_ENC1_BTN GPIO_NONE		// SW

// 3 Buttons
//-------------
#define PIN_BTN0_A   GPIO_NONE		
#define PIN_BTN0_B   GPIO_NONE		
#define PIN_BTN0_C   GPIO_NONE		
#define PIN_BTN1_A   GPIO_NONE		
#define PIN_BTN1_B   GPIO_NONE		
#define PIN_BTN1_C 	 GPIO_NONE		

// I2C lcd (and rda5807 if lcd is i2c or LCD_NONE)
//------------------------------------------------
#define PIN_I2C_SCL GPIO_NUM_14
#define PIN_I2C_SDA GPIO_NUM_13
#define PIN_I2C_RST	GPIO_NUM_2		// or not used


// SPI lcd
//---------
#define PIN_LCD_CS	GPIO_NUM_13		//CS
#define PIN_LCD_A0	GPIO_NUM_14		//A0 or D/C
#define PIN_LCD_RST	GPIO_NUM_2		//Reset RES RST or not used
// KSPI pins +

// IR Signal
//-----------
#define PIN_IR_SIGNAL GPIO_NUM_21	// Remote IR source


// I2S DAC or PDM output
//-----------------------
#define PIN_I2S_LRCK GPIO_NUM_25	// or Channel1
#define PIN_I2S_BCLK GPIO_NUM_26	// or channel2
#define PIN_I2S_DATA GPIO_NUM_22	//  

// ADC for keyboard buttons
#define PIN_ADC	GPIO_NONE	//GPIO_NUM_32 TO GPIO_NUM_39 or GPIO_NONE if not used.

```

## First use
- If the acces point of your router is not known, the webradio inits itself as an AP. Connect the wifi of your computer to the ssid "WifiKaRadio",  
- Browse to 192.168.4.1 to display the page, got to "setting" "Wifi" and configure your ssid ap, the password if any, the wanted IP or use dhcp if you know how to retrieve the dhcp given ip (terminal or scan of the network).
- In the gateway field, enter the ip address of your router.
- Validate. The equipment restart to the new configuration. Connect your wifi to your AP and browse to the ip given in configuration.
- Congratulation, you can edit your own station list. Dont forget to save your stations list in case of problem or for new equipments.
- if the AP is already know by the esp32, the default ip is given by dhcp.
- a sample of stations list is on http://karadio.karawin.fr/WebStations.txt . Can be uploaded via the web page.        


<br/>
<br/>
To flash your KaRadio32 you will need these files:<br/>

http://karadio.karawin.fr/KaRadio32.bin <br/>
and<br/>
http://karadio.karawin.fr/KaRadio32sup.zip <br/>
The tool to use is here: http://espressif.com/en/support/download/other-tools <br/>
(change the security of the installation directory to permit all)<br/>
See the image at http://karadio.karawin.fr/karawin32Flash.jpg <br/>

<img src="https://github.com/karawin/Ka-Radio32/blob/master/images/downloadtool32.jpg" alt="screenshot" border=0> 
<br/><br/>
The scheme from tomasf71</br>
<img src="https://github.com/karawin/Ka-Radio32/blob/master/images/schemekaradio32.jpg" alt="scheme" border=0> 
<br/>

## Audio output

In the Setting panel on the webpage of KaraDio32 you can set the desired output method for audio.

For output on a simple speaker or a general analog amplifier
- DAC to use the built in DAC of the esp32
- PDM to output a PDM (Pulse Density Modulation) stream. Wiki on PDM : https://en.wikipedia.org/wiki/Pulse-density_modulation

For output via addional I2S or VS1053 hardware
- I2S for connection to ac external DAC
- I2SMERUS to connect a merus amplifier
- VS1053 to connect to a vs1053 board.

### Connecting a speaker, earphone or amplifier with DAC or PDM setting
You can connect the GPIO25 (left audio channel), GPIO26 (right audio channel) and Ground directly to a small loudspeaker, a simple earphone (like from an mp3 player) or the input of an analog amplifier. The quality is less perfect than using an I2S or VS1053 board, bit it is very simple hardware-wise.

Connect like this
```
                         +------------------------------------+
ESP32-GPIO25 (left) -----+speaker/earphone/analog-amp (left)   +-----+
                         +------------------------------------+      |
                                                                     |
                         +------------------------------------+      |
ESP32-GPIO26 (right) ----+speaker/earphone/analog-amp (right  +------+
                         +------------------------------------+      |
                                                                     |
ESP32-GROUND --------------------------------------------------------+
```

### Reducing the analog output level
If the audio signal level is too high for your speaker, earphone or amplifier you can add a potentiometer to decrease the level. Connect the potentiometer like this (only pictured for 1 audio channel, for stereo you need 2 potentiometers or a stereo-potmeter.

```
                                     +--------------------------------------+
ESP32-GPIO25 (left) -------+   +-----+speaker/earphone/analog-amp (left)    +------+
                          +-+  |     +--------------------------------------+      |
                          +P+  |                                                   |
                          +o+--+                                                   |
                          +t+                                                      |
                          +++                                                      |
                           |                                                       |
ESP32-GROUND --------------+-------------------------------------------------------+
```
### Improving the audio quality with a filter
An analog DAC signal always has some noise that may cause some distortion on the audio output, especially on low volume passages in the sound. This noise can be decreased with a low-pass filter. The digital PDM signal needs allways low pass filter to convert the digital signal to an analog signal. Fortunately the speaker and earphone acts as a low pass filter, although not in a perfect way.

You can improve the analog signal with an external low-pass filter. A simple low-pass RC filter can be find on the internet, f.i. here : http://www.pavouk.org/hw/usbdac/en_index.html.

## Radio streams
If Karadio32 is configured to use ADC, PDM or I2S output (to an external dac) it can play audio streams in mp3 format. Other formats like AAC and WMV require too much dynamic memories and can not be played this way.

When you want to play other formats you add an external VS1053 decoder to Karadio. Details on the features of this decoder can be found here : http://www.vlsi.fi/en/products/vs1053.html


Many boards can be found at https://www.aliexpress.com/wholesale?catId=0&initiative_id=SB_20180113141636&SearchText=vs1053b

## Handling streaming errors

Normally a radio station is played without interruption.

But when a connection to the server of the radio station is (temporarily) disrupted (due to internet problems or server problems) Karadio behaves as follows:
- Playing of the radio stream stops, after a short while Karadio retries to relaunch the connection to the radio stream.
- If the relaunch of the connection fails again, the webpage of Karadio then shows “invalid address” and goes into the stop state. If you have a display connected to Karadio it will then show the Date, Time and IP address.
- You can try to relaunch the connection manually by pressing “play” on the Karadio webpage, or resetting the ESP32.
- If the wifi is disconnected, the esp is rebooted.

## List of sources and components adapted for KaRadio32
<br/>
https://github.com/espressif/esp-idf  the espressif IDF<br/>
https://hackaday.io/project/11570-wifi-webradio-with-esp8266-and-vs1053  The esp8266 KaRadio<br/>
https://github.com/karawin/karadio-addons  The KaRadio addons<br/>
https://github.com/kodera2t/ESP32_OLED_webradio  webradio for ESP-ADB module<br/>
https://github.com/MrBuddyCasino/ESP32_MP3_Decoder  webradio with the MP3 decoder software<br/>
https://github.com/olikraus/u8g2  Black/White oled lcd library<br/>
https://github.com/olikraus/ucglib  color lcd library<br/>
https://github.com/nkolban/esp32-snippets/tree/master/hardware/displays/U8G2  u8g2 Hal for esp32<br/>
https://github.com/soligen2010/encoder  Encoder<br/>


<img src="https://github.com/karawin/Ka-Radio32/blob/master/images/2017-11-11%2009.50.50.jpg" alt="screenshot" border=0> 
<br/>
 	



