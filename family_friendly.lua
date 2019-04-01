admin= {["Themiachale#0000"]=true, ["Venceslai#0000"]=true, ["Gismina#0000"]=true, ["Skiinovecent#0000"]=true, ["Themiachale2#7887"]=true, ["Sabrygame#2987"]=true}



tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
tfm.exec.newGame("@7493263")
-- stopped at line 144.
players={}--respawn place is 400,320
p={}
timestamp=os.time()
numplayers=0

begin=false
answerer="lol"
questioner="lol"
question="lol"
ans="lol"
new=false
restart=false
choose=false
start=true
restart=false
choosey=false
skip=false

truth={}--you can follow the format 'truth[number]="question"' 
truth[1]="Chi ti piace su Transformice?"
truth[2]="Qual è il tuo cibo preferito?"
truth[3]="Qual è il tuo più grande sogno?"
truth[4]="A che altri giochi giochi oltre a Transformice?"
truth[5]="Come ti descriveresti?"
truth[6]="Hai mai rubato qualcosa?"
truth[7]="Di che marca è il telefono che usi attualmente?"
truth[8]="Chi ti sta più antipatico tra i presenti?"
truth[9]="Se tu potessi hackerare Transformice, cosa faresti?"
truth[10]="Se dovessi scegliere, quale sarebbe la tua fur preferita su Transformice?"

dare={}--you can follow the format 'dare[number]="Dare"' 
dare[1]="Ti obbligo ad andare in una room e spammare in chat: I AM A GUMMY BEAR! I AM A GUMMY BEAR! I AM A GUMMY BEAR!"
dare[2]="Ti obbligo ad usare 10 selfie, se non li possiedi li devi comprare."
dare[3]="OBBLIGO DI GRUPPO! Tutti i presenti ballino per un giro."
dare[4]="Ti obbligo a dare un bacio ad una persona nella stanza."
dare[5]="Ti obbligo a indossare per 1 giorno (su Transformice) un outfit che non ti piace."
dare[6]="Ti obbligo ad abbracciare una persona nella stanza!"
dare[7]="Ti obbligo a giocare a 'Sasso Carta Forbici' con me, chi perde paga un cheese al vincitore."
dare[8]="Ti obbligo ad inviare un selfie del tuo topo con un look assurdo nella chat della tribù."
dare[9]="Ti obbligo ad andare in una qualsiasi utility con almeno 5 persone e farla crashare."
dare[10]="Ti obbligo a scambiare un tuo cheese per un mio costume casuale."

ui.addTextArea(1,"<b><p align = 'center'><font size='30'>Benvenuto al gioco di: Obbligo o Verità!</font></p></b>",nil,50,355,700,40,0x324650,0x212F36,0.8,true)


function eventNewPlayer(name)
ui.addTextArea(1,"<b><p align = 'center'><font size='30'>Digita !join per partecipare.</font></p></b>",name,50,355,700,40,0x324650,0x212F36,0.8,true)
p[name]={questioners=false, answerers=false, spectator=true}
end

function eventNewGame()
numplayers=0
count=1
for name,player in pairs(tfm.get.room.playerList) do
p[name]={questioners=false, answerers=false, spectator=true}
players[count]=name
timestamp=os.time()
numplayers=numplayers+1
count=count+1
p[name].spectator=false
p[name].questioners=false
end
print(numplayers)
end

function eventChatCommand(name,command)
if command=="s" and admin[name] then
tfm.exec.setShaman(name)		
elseif command=="join" and p[name].spectator==true then
tfm.exec.respawnPlayer(name)
tfm.exec.movePlayer(name,400,320,false,0,0,false)
numplayers=numplayers+1
players[numplayers]=name
p[name].spectator=false
elseif command=="skip" and admin[name] then
timestamp=os.time()
skip=true
end
end

tfm.exec.setNameColor(admin, 0x009DFF)
tfm.exec.setUIMapName("Obbligo o Verità")
function eventLoop(time,remaining)
if timestamp < os.time()-10000 and begin==false then
timestamp=os.time()
begin=true
restart=false
ui.updateTextArea(1, "<p align='center'><b><font size='30'>Iniziamo a giocare! </font></b></p>", nil)
elseif timestamp < os.time()-5000 and begin==false then
local i=1
local long=""
while i<numplayers do
long=long..tostring(players[i])..", "
i=i+1
end
long=long..tostring(players[numplayers])..".</font></b>"
ui.updateTextArea(1, "<p align='center'><b><font size='15'>I partecipanti sono: "..long, nil)
elseif timestamp < os.time()-3000 and begin==false and restart==true then
ui.updateTextArea(1, "<p align='center'><b><font size='20'>Visto che tutti hanno compiuto il loro turno, Restarting...", nil)
end
if begin==true then
if timestamp < os.time()-3000 and start==true then
tfm.exec.movePlayer(questioner,400,320,false,0,0,false)
tfm.exec.movePlayer(answerer,400,320,false,0,0,false)
answerer=""
questioner=""
local j=1
local i=0
while j<=numplayers do
pname=players[j]

if p[pname].questioners==false then
i=i+1
end
j=j+1
end
if i>0 then
eventTruthOrDare()
else
local j=1
while j<=numplayers do
local name=players[j]
p[name].questioners=false
j=j+1
end
restart=true
timestamp=os.time()
begin=false
end
end
if choose==true then
	rand=math.random(1,numplayers)
	print(questioner)
	answerer=players[rand]
	print(answerer)
	if questioner==answerer then
	ui.updateTextArea(1, "<p align='center'><b><font size='30'>Randomizzando...</font></b></p>", nil)
	tfm.exec.movePlayer(answerer,400,320,false,0,0,false)
	answerer=""
	else
	choose=false
	ui.updateTextArea(1, "<b><font size='15'>"..answerer.." deve rispondere! Aspettando che scelga obbligo o verità...</font></b>", nil)
	ui.addPopup(3,1,"Hey, ti hanno scelto! Preferisci verità? Se clicchi <b>'No'</b>, sceglierai obbligo!",answerer,250,50,300,true)
	end
elseif choosey==true then
	rand=math.random(1,numplayers)
	questioner=players[rand]
	print(questioner)
	print(p[questioner].questioners)
	if p[questioner].questioners==false then
		choosey=false
		p[questioner].questioners=true
		ui.updateTextArea(1, "<b><font size='15'>"..questioner.." è l'interrogatore! Aspettando che scelga un giocatore...</font></b>", nil)
		ui.addPopup(1,1,"Vuoi un giocatore casuale? Se clicchi <b>'No'</b>, dovrai scrivere l'username del giocatore.",questioner,250,50,300,true)
	elseif p[questioner].questioners==true then
		ui.updateTextArea(1, "<p align='center'><b><font size='30'>Randomizzando...</font></b></p>", nil)
		tfm.exec.movePlayer(questioner,400,320,false,0,0,false)
		questioner=""
	end
end
if skip==true then
ui.updateTextArea(1, "<p align='center'><b><font size='30'>Skippando il turno...</font></b></p>", nil)
if timestamp < os.time()-3000 then
start=true
skip=false
end
end
tfm.exec.movePlayer(questioner,120,120,false,0,0,false)
tfm.exec.movePlayer(answerer,680,120,false,0,0,false)
end
end

function eventTruthOrDare()
	start=false
	ui.removeTextArea(2)
	ui.removeTextArea(3)
	choosey=true

end

function eventPopupAnswer(id, name, answer)
	if id==1 and name==questioner then
		if answer=="yes" then
			choose=true
		elseif answer=="no" then
			ui.addPopup(2,2,"Chi vuoi che risponda?",questioner,250,50,300,true)
		end
	elseif id==2 and name==questioner then
		x=1
		found=false
		while x<=numplayers do
		print(players[x])
			if answer==players[x] then
			answerer=answer
			if questioner==answerer then
			answerer=""
			found=false
			else
			ui.updateTextArea(1, "<b><font size='15'>"..answerer.." è stato/a scelto/a! In attesa che scelga obbligo o verità...</font></b>", nil)
			ui.addPopup(3,1,"Hey, ti hanno scelto! Preferisci verità? Se cliccherai <b>'No'</b>, sceglierai Obbligo!",answerer,250,50,300,true)
			found=true
			end
			end
			x=x+1
		end
		if found==false then
			ui.addPopup(2,2,"Non c'è nessuno con quel nome. Digita l'esatto username dell'utente a cui vuoi fare la domanda.",questioner,250,50,300,true)
		end
	elseif id==3 and name==answerer then	
		if answer=="yes" then
			ui.updateTextArea(1, "<b><font size='15'>"..answerer.." Ha scelto verità! In attesa della domanda da parte di "..questioner.."...</font></b>", nil)	
			ui.addPopup(4,1,"Vuoi una domanda casuale? Se cliccherai <b>'No'</b>, dovrai scrivere una domanda.",questioner,250,50,300,true)
		elseif answer=="no" then
			ui.updateTextArea(1, "<b><font size='15'>"..answerer.." ha scelto obbligo! In attesa dell'obbligo da parte di "..questioner.."...</font></b>", nil)
			ui.addPopup(5,1,"Vuoi un obbligo casuale? Se cliccherai <b>'No'</b>, dovrai scrivere l'obbligo.",questioner,250,50,300,true)
				
		end
	elseif id==4 and name==questioner then
		if answer=="yes" then
			question=truth[math.random(1,10)]
			ui.updateTextArea(1, "<b><font size='15'>"..questioner.." Ha scelto una verità casuale! Aspettando che "..answerer.." risponda...</font></b>", nil)	
			ui.addTextArea(2,"<b><font size='20'>Verità: "..question.."</font></b>",nil,165,20,470,120,0x324650,0x212F36,0.8,true)
			ui.addPopup(8,2,"<b>Scrivi la tua risposta qui sotto.</b>",answerer,250,175,300,true)
			--need to ask if questioner is satisfied with answer
		elseif answer=="no" then
			ui.addPopup(6,2,"Scrivi la tua domanda qui sotto.",questioner,250,50,300,true)
		end
	elseif id==5 and name==questioner then
		if answer=="yes" then
			question=dare[math.random(1,10)]
			ui.updateTextArea(1, "<b><font size='15'>"..questioner.." ha scelto un obbligo casuale! Aspettando che "..answerer.." risponda...</font></b>", nil)	
			ui.addTextArea(2,"<b><font size='20'>Obbligo: "..question.."</font></b>",nil,165,20,470,120,0x324650,0x212F36,0.8,true)
			ui.addPopup(9,1,"<b><font size='15'>Fai quello che "..questioner.."ti ha obbligato! Se cliccherai <b>'Sì'</b>, prometterai di fare il tuo obbligo!</font><b>",answerer,250,175,300,true)
		elseif answer=="no" then
			ui.addPopup(7,2,"Scrivi il tuo obbligo qui sotto.",questioner,250,50,300,true)
		end
	elseif id==6 and name==questioner then
		question=answer
		ui.updateTextArea(1, "<b><font size='15'>"..questioner.." ha scritto una domanda! Aspettando che "..answerer.." risponda...</font></b>", nil)	
		ui.addTextArea(2,"<b><font size='20'>Verità: "..question.."</font></b>",nil,165,20,470,120,0x324650,0x212F36,0.8,true)
		ui.addPopup(8,2,"Scrivi la tua risposta qui sotto.",answerer,250,175,300,true)
	elseif id==7 and name==questioner then
		question=answer
		ui.updateTextArea(1, "<b><font size='15'>"..questioner.." ha scritto un obbligo! Aspettando che "..answerer.." risponda...</font></b>", nil)	
		ui.addTextArea(2,"<b><font size='15'>Obbligo: "..question.."</font></b>",nil,165,20,470,120,0x324650,0x212F36,0.8,true)
		ui.addPopup(9,1,"<b><font size='15'>Fai quello che "..questioner.."ti ha obbligato! Se cliccherai <b>'Sì'</b>, prometterai di fare il tuo obbligo!</font><b>",answerer,250,175,300,true)
	elseif id==8 and name==answerer then
		ans = answer
		ui.addTextArea(3,"<b><font size='20'>Risposta: "..ans.."</font></b>",nil,165,140,470,120,0x324650,0x212F36,0.8,true)
		ui.updateTextArea(1, "<b><font size='15'>"..answerer.." ha risposto! Aspettando che "..questioner.." voti la sua risposta</font></b>", nil)	
		ui.addPopup(10,1,"<b><font size='15'>La sua risposta è stata esaustiva?",questioner,250,50,300,true)
	elseif id==9 and name==answerer then
		if answer=="yes" then
			ui.addTextArea(3,"<b><font size='20'>Io, "..answerer..", accetto l'obbligo e prometto di svolgerlo.</font></b>",nil,165,140,470,120,0x324650,0x212F36,0.8,true)
			ui.updateTextArea(1, "<b><font size='15'>"..answerer.." è un/a guerriero/a! Startando una nuova partita...</font></b>", nil)	
			timestamp=os.time()
			answerer=""
			questioner=""
			start=true
			for name,player in pairs(tfm.get.room.playerList) do
			tfm.exec.movePlayer(name,400,320,false,0,0,false)
			end			
		elseif answer=="no" then
			ui.updateTextArea(1, "<b><font size='15'>"..answerer.." è un/a codardo/a! Startando una nuova partita...</font></b>", nil)	
			ui.addTextArea(3,"<b><font size='20'>Io, "..answerer..", sono un/a codardo/a quindi non farò l'obbligo che mi hai chiesto di fare.</font></b>",nil,165,140,470,120,0x324650,0x212F36,0.8,true)
			timestamp=os.time()
			answerer=""
			questioner=""
			start=true
			for name,player in pairs(tfm.get.room.playerList) do
			tfm.exec.movePlayer(name,400,320,false,0,0,false)
			end			
		end
	elseif id==10 and name==questioner then
		if answer=="yes" then
			ui.updateTextArea(1, "<b><font size='15'>"..questioner.." è soddisfatto/a della risposta! Startando una nuova partita...</font></b>", nil)
			timestamp=os.time()
			answerer=""
			questioner=""
			start=true
			for name,player in pairs(tfm.get.room.playerList) do
			tfm.exec.movePlayer(name,400,320,false,0,0,false)
			end
		elseif answer=="no" then
			ui.updateTextArea(1, "<b><font size='15'>"..questioner.." non è soddisfatto/a della risposta... :( Startando una nuova partita...</font></b>", nil)
			timestamp=os.time()
			answerer=""
			questioner=""
			start=true			
			for name,player in pairs(tfm.get.room.playerList) do
			tfm.exec.movePlayer(name,400,320,false,0,0,false)
			end
		end
	end
end

function eventPlayerLeft(name)
ui.updateTextArea(1, "<p align='center'><b><font size='15'>"..name.." è uscito dalla stanza... Che codardo/a!</font></b></p>", nil)
end

function eventPlayerDied(name)
tfm.exec.respawnPlayer(name)
end

changelog = "<p align='center'><font size='26'> Obbligo o Verità </font></p><br /><br />"
changelog = changelog .. "• Se siete entrati in ritardo, basta fare !join per partecipare.<br />"
changelog = changelog .. "• Gli admin della stanza possono skippare il turno facendo !skip.<br />"
changelog = changelog .. "<br />"
changelog = changelog .. "• Gli admin della stanza sono:<br />"
changelog = changelog .. "<br />"
changelog = changelog .. "  Themiachale    Venceslai    Sabrygame     Gismina     Skiinovecent <br />"
changelog = changelog .. " <br />"
 
ui.addPopup(0, 0, changelog, nil, 200, 100, 400, true)

-- Credits to Mousetat.
