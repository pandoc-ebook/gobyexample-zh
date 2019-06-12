COVER ?= R
DEVICE ?= pc
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=思源黑体,ItalicFont=KaiTi

all: zhctex zhelegant enctex enelegant bothctex bothelegant
zhctex:
	panbook book -V cover:$(COVER) -V device:$(DEVICE)
zhelegant:
	panbook book --style=elegantbook -V device:$(DEVICE)
enctex:
	panbook book -V cover:$(COVER) -V device:$(DEVICE) -G ext-zh_en-lang:en -V lang:en
enelegant:
	panbook book --style=elegantbook -V cover:$(COVER) -V device:$(DEVICE) -G ext-zh_en-lang:en -V lang:en
bothctex:
	panbook book -V cover:$(COVER) -V device:$(DEVICE) -G ext-zh_en-lang:both
bothelegant:
	panbook book --style=elegantbook -V cover:$(COVER) -V device:$(DEVICE) -G ext-zh_en-lang:both
clean:
	panbook clean