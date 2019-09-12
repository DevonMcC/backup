NB.* exclusions.ijs: list of directories to exclude from usual backups
NB. because they change often due to processes about which I don't care
NB. or they get updated sometimes with very large files.
NB. This was formerly part of "parseDir.ijs" but I broke it out when I
NB. realized I also need it in "parallelParseDir.ijs".

NB.* rmEndSep: remove terminal path separator from string.
NB.* extractExclusions: extract names of target, exclude dirs, and files from global EXCLUDEUSUAL.
NB.* EXCLUDEUSUAL: list of usual files and directories to exclude from backup.

NB.* rmEndSep: remove terminal path separator from string.
rmEndSep=: 3 : '(]}.~[:-PATHSEP_j_={:)"1 dtb y'

extractExclusions=: 3 : 0
NB.* extractExclusions: extract names of target, exclude dirs, and files from global EXCLUDEUSUAL.
   targ=. rmEndSep y               NB. Exclude target to avoid unwanted recursion.
   sections=. '[ExcludeDirs]';'[ExcludeFiles]'
   xu=. EXCLUDEUSUAL
   xu=. xu#~&.>-.&.>+./\&.>(<'NB.')E.&.>xu  NB. Exclude comments
   xu=. xu#~0~:;#&.>xu
   whsect=. >+./&.>sections E.&.>/ xu
   secord=. /:sections i. ' '-.~&.>xu#~+./whsect
   targ;secord{(+./whsect)<;._1 xu
NB.EG 'targ xd xf'=. extractExclusions y
)

NB. Exclude the usual files and directories from being copied given list of Files &
NB. Directories (result of munge_dir) & source Disk & target Disk[:\dir] names.
NB. Some DBs big enough to be done separately.
NB. Need to include a [regexp] exclusion section to apply to files, e.g.
NB. "saves-{d}*", "*~", etc.

NB. Use this to exclude nothing.
EXCLUDEUSUAL=: '[ExcludeDirs]';'[ExcludeFiles]'

NB.* EXCLUDEUSUAL: list of usual files and directories to exclude from backup.
EXCLUDEUSUAL=: <;._2 CR-.~jpathsep 0 : 0
[ExcludeDirs]
avg
$Recycle.Bin
.emacs.d
.eshell
Alphaworks
amisc\Ainfo\code\HiggsBoson\Data
amisc\Ainfo\FlSzs
amisc\Ainfo\sentmail
amisc\Clarifi\Amisc\ToBeGlommed
amisc\Clarifi\Data
amisc\Clarifi\Data\Pairs
amisc\Clarifi\Empiric\Flatfiles
amisc\Clarifi\Hillsdale\CanadaRiskModel
amisc\Clarifi\LeeRushton\Data
amisc\Clarifi\Weiss\RiskModel\updates
amisc\Clarifi\Weiss\RiskModel\SavePre
amisc\DCIM
amisc\gnuwin32
amisc\Incoming
amisc\jsys\temp\jbreak
amisc\J\NASAClementine
amisc\J\Parallel\ExampleProblems\FlipPics
amisc\pix\OnlyFolds
amisc\pix\Photos
amisc\pix\Photos\2012Q4
amisc\pix\Sel
amisc\pix\ToFold
amisc\sound
amisc\Sound\Music
amisc\work\AgentBasedSimulation\FullGameNoBet
ant
avayamgrmgrinst
binaries
Boot
ca_lic
cdoevaluator3.3
CFGSAFE
Clarifi
Clarifi\RiskModels
Clarifi5220
Clarifi5310
Clarifi5313
Clarifi532
Clarifi5.3.15
ClarifiWork
COLLEGE CDs
C_DILLA
DACSS21
Data
Data\Mercurial
Data\Mercurial-clone
Data\Netflix\VarsDir
dell
Documents and Settings
documentum
downloads
DRV
i386
Informatica
Intel
Intex_Phase1.4.4
J7W
Java
LEVELS61
levels61
LEVELS62
logs
Macromedia
Mercurial
MSOCache
My Dropbox
oracle
PDMEngineTest
Pgm\d2cpp-0.1.0
Pgm\Python27\Lib
Pgm\Python35-32\Lib
Pgm\Python37-64\Lib
pgm\R
pgm\strawberry
Program Files (x86)
Program Files
ProgramData
Recycled
Recycler
ScanSoft Documents
Sengent
source_control
SP
SPIRE22SO
SPIRE_NET
strawberry
SUSIDChk
swshare
temp
TestHFE2.0
TestHFE2.1
TestHFE2.2
TestHFE2.2_Dec2009
TestHFE20
Users\Administrator
Users\All Users
Users\devon_mccormick\.cisco
Users\devon_mccormick\AppData
Users\devon_mccormick\Documents
Users\devon_mccormick\j64-807-user
Users\devon_mccormick\TOSHIBA
Users\devon_mccormick\Tracing
Users\itsupport
Users\MSSQL$DHM
Users\Public
Utl\Paint Shop Pro
vbroker
WINDOWS
ws
zenworks

[ExcludeFiles]   NB. Files to exclude from any directory
~
*.bz2
*.filters
*.idb
*.ilk
*.lastbuildstate
*.manifest
*.obj
*.pdb
*.rc
*.res
*.sdf
*.sln
*.tlog
*.user
*.vcxproj
*.zip
.history
.bash_history
.emacs~
AUTOEXEC.BAT
CONFIG.SYS
DHMTest*
freefallprotection.log
GII_ICD.txt
IO.SYS
MSDOS.SYS
NTDETECT.COM
NTLDR
RatingIdx.txt
RewardIdx.txt
RiskIdx.txt
SECURITY
SOFTWARE
stderr_Server.txt
stdout_Server.txt
SYSTEM
SYSTEM.ALT
Setup.log
Thumbs.db
USER0000.log
boot.ini
default.dlf
eventlog.log
fold0000.frm
git_shell_ext_debug.txt
hiberfil.sys
installer_debug.txt
keepAlive.log
mdr.log
pagefile.sys
pspbrwse.jbf
quote.flag
sysiclog.txt
)
NB.*** Need to actually use the wildcards in the file list above!!!

EV=: getEnviVars ''
WINDIR=: endSlash ,>EV{~<1,~(toupper&.>0{"1 EV)i.<'WINDIR'

NB. Replace WINNT with actual Windows system dir from environment var.
EXCLUDEUSUAL=: ('WINNT';<'\'-.~WINDIR}.~WINDIR i. '\') stringreplace EXCLUDEUSUAL
