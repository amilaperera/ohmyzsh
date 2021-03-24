# Attribute codes: 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes: 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes: 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
# Extra color codes: 90=Dark grey 91=Light red 92=Light green 93=Yellow 94=Light blue 95=Light purple 96=Turquoise
#                    97=White
#                    100=Dark grey bg 101=Light red bg 102=Light green bg 103=Yellow bg 104=Light blue bg
#                    105=Light purple bg 106=Turquoise bg

# setting LS_COLORS

autoload -U colors
colors

LS_COLORS='rs=0:di=01;94:ln=00;36:pi=40;33:so=00;35:do=01;35:bd=40;33;01'
LS_COLORS="${LS_COLORS}":'cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
LS_COLORS="${LS_COLORS}":'*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31'
LS_COLORS="${LS_COLORS}":'*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31'
LS_COLORS="${LS_COLORS}":'*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31'
LS_COLORS="${LS_COLORS}":'*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31'
LS_COLORS="${LS_COLORS}":'*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31'
LS_COLORS="${LS_COLORS}":'*.a=01;37'

LS_COLORS="${LS_COLORS}":'*.jpg=01;35:*.JPG=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35'
LS_COLORS="${LS_COLORS}":'*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35'
LS_COLORS="${LS_COLORS}":'*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35'
LS_COLORS="${LS_COLORS}":'*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:'
LS_COLORS="${LS_COLORS}":'*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35'
LS_COLORS="${LS_COLORS}":'*.anx=01;35:*.ogv=01;35:*.ogx=01;35'

LS_COLORS="${LS_COLORS}":'*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36'
LS_COLORS="${LS_COLORS}":'*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36'
LS_COLORS="${LS_COLORS}":'*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36'

LS_COLORS="${LS_COLORS}":'*.c=96:*.cpp=00;04;95:*.cxx=00;04;95:*.c++=00;04;95'
LS_COLORS="${LS_COLORS}":'*.h=32'
LS_COLORS="${LS_COLORS}":'*.rb=00;33'
LS_COLORS="${LS_COLORS}":'*.erb=04;33'

LS_COLORS="${LS_COLORS}":'*.csv=01;37;45:*.dsv=01;37;45:*.db=01;37;45:*.sql=01;37;45:*.meta=01;37;45'
LS_COLORS="${LS_COLORS}":'*.xml=01;37;45:*.yaml=01;37;45:*.yml=01;37;45:*.conf=01;37;45'

LS_COLORS="${LS_COLORS}":'*.bak=07:*.orig=07:*.swp=07'

LS_COLORS="${LS_COLORS}":'*.txt=00;04;91:*.notes=00;04;91'
LS_COLORS="${LS_COLORS}":'*.pdf=01;04;32'
LS_COLORS="${LS_COLORS}":'*.html=00;04;94:*.htm=00;04;94'

LS_COLORS="${LS_COLORS}":'*.diff=00;35;47:*.patch=00;35;47'

export LS_COLORS

# use exported LS_COLORS for completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

