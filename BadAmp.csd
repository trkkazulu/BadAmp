<Cabbage>
form caption("Bad Amp") size(400, 100), colour(58, 110, 182), pluginid("def1")
image bounds(0, 0, 400,100), file("gold_gradient.png"),colour("brown"), shape("rounded"), outlinecolour("white"), outlinethickness(4)
rslider bounds(300, 0, 100, 100), channel("gain"), range(0, 1, 0, 1, 0.01), text("Gain"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255) colour(183, 53, 53, 255)
rslider bounds(0, 0, 100, 100), channel("bump"), range(0, 11, 0, 1, 1), text("Bump"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255) colour(183, 53, 53, 255)
rslider bounds(150, 0, 100, 100), channel("gash"), range(0, 100, 0, 1, 5), text("Gash"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255) colour(183, 53, 53, 255)

</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

gifn	ftgen	0,0, 257, 9, .5,1,270	


instr 1
kGain chnget "gain"
kBump chnget "bump"
kGash chnget "gash"

;a1 inch 1
;a2 inch 2

a1 diskin2 "bassClipCR.wav", 1,0,1

ares pareq a1, 120, kBump, 0.5,1
ares2 pareq a1, 10000, kGash, 0.2, 0

asig = ares
asig2 = ares2

ad distort asig2, 0.68, gifn

aOut = asig+ad*.03

ar compress aOut, aOut, -2.5, 48, 60, 2, 0.2, .5, .02

printks2 "Gash value now %f\n", int(kGash)

;asig	=	ares+ares2 * kGain * (1 - ((kBump+kGash*0.3)^0.02)) ;This scales the output so that by the bump and gash levels so that it doesn't blow up



outs ar*kGain, ar*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
