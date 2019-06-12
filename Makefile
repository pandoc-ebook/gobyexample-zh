COVER ?= R
DEVICE ?= pc
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=思源黑体,ItalicFont=KaiTi
SUBTITLE ?= -M subtitle:

all: zhelegant enelegant bothelegant
zhelegant:
	panbook book --style=elegantbook -V device:$(DEVICE)
enelegant:
	panbook book --style=elegantbook -V cover:$(COVER) -V device:$(DEVICE) -G ext-zh_en-lang:en -V lang:en $(SUBTITLE)
bothelegant:
	panbook book --style=elegantbook -V cover:$(COVER) -V device:$(DEVICE) -G ext-zh_en-lang:both
clean:
	panbook clean