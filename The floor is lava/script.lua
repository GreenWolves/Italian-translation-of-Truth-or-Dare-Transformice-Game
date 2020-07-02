map={
7495586,
7495541,
7498657,
7498663
}
tfm.exec.setGameTime(6000,true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.newGame(map[math.random(#map)])
ilosc = 10
for name, player in pairs(tfm.get.room.playerList) do
tfm.exec.setPlayerScore(name,0)
end
tfm.exec.addPhysicObject(1,800,387,{
type=6,
restitution=0.2,
friction=0.3,
width=1600,
height=37,
groundCollision=true,
miceCollision=true
})
to=0
czas=10
score = 0


function eventLoop(timeRemaining,timeRemaining)
tfm.exec.setUIMapName("The Floor is Lava by Themiachale")
if(to==2) then
czas=czas-1
score = score + 1
if(score==10) then
for name, player in pairs(tfm.get.room.playerList) do
tfm.exec.giveMeep(name)
end
end
if(czas==3) then
usun = tfm.exec.addShamanObject(math.random(1,7),math.random(100,1500),350,0,0,0,false)
usunn = tfm.exec.addShamanObject(math.random(1,7),math.random(100,1500),350,0,0,0,false)

end
if(czas==-3) then
tfm.exec.removeObject(usun)
tfm.exec.removeObject(usunn)

ilosc = ilosc - 1
czas=ilosc
tfm.exec.addPhysicObject(1,800,387,{
type=6,
restitution=0.2,
friction=0.3,
width=1600,
height=37,
groundCollision=true,
miceCollision=true
})	
tfm.exec.removePhysicObject(2)
end

if(czas<=0) then

tfm.exec.addPhysicObject(1,800,387,{
type=6,
restitution=0.2,
friction=0.3,
width=1600,
height=37,
groundCollision=true,
miceCollision=false
})
tfm.exec.addPhysicObject(2,800,387,{
type=3,
restitution=0.2,
friction=0.3,
width=1600,
height=37,
groundCollision=true,
miceCollision=false
})

ui.addTextArea(7, "<p align='center'><font size='50' color='#A60401'>T<font size='50' color='#FF0000'>H<font size='50' color='#A60401'>E <font size='50' color='#FF0000'>F<font size='50' color='#A60401'>L<font size='50' color='#FF0000'>O<font size='50' color='#A60401'>O<font size='50' color='#FF0000'>R <font size='50' color='#A60401'>I<font size='50' color='#FF0000'>S <font size='50' color='#A60401'>L<font size='50' color='#FF0000'>A<font size='50' color='#A60401'>V<font size='50' color='#FF0000'>A!</font></p>", nil, 50, 125, 700, 119, 0x324650, 0x000000, 0, true,true)
else
ui.addTextArea(7, "<p align='center'><font size='90'>"..czas.."</font></p>", nil, 50, 125, 700, 119, 0x324650, 0x000000, 0, true,true)
ui.addTextArea(5,"", nil, 50, 250, 700, 119, 0x324650, 0x000000, 0, true,true)
end
to=0
else
to=to+1
end
if(ilosc==4) then
ilosc=10
end
end
liczba=0
tablica={}
zycie={}
e=0
for name, player in pairs(tfm.get.room.playerList) do
tablica[name]=0
e=e+1

print(name)
end
print(e)
function eventPlayerDied(n)
tfm.exec.setUIShamanName(n.." è morto/a.")
tfm.exec.setPlayerScore(n,-2,true)
tablica[n]=1
zycie[n]=0
e=e-1
print(e)
for name, player in pairs(tfm.get.room.playerList) do
if(tablica[name]==0) then
liczba=liczba+1
wyg=name
end
end
function eventPlayerLeft(n)
tablica[n]=1
zycie[n]=0
e=e-1
print(e)
for name, player in pairs(tfm.get.room.playerList) do
if(tablica[name]==0) then
liczba=liczba+1
wyg=name
end
end
end
if(liczba==1) then
print(wyg.." wygral")
tfm.exec.giveCheese(wyg)
ui.addTextArea(5, "<p align='center'><font size='50' color='#D09804'>"..wyg.." ha vinto questa partita!</font></p>", nil, 50, 250, 700, 500, 0x324650, 0x000000, 0, true,true)
tfm.exec.playerVictory(wyg)
tfm.exec.newGame(map[math.random(#map)])
tfm.exec.addPhysicObject(1,800,387,{
type=6,
restitution=0.2,
friction=0.3,
width=1600,
height=37,
groundCollision=true,
miceCollision=true
})
to=0
czas=10
score = 0
e=0
tablica={}
ilosc=10
tfm.exec.setPlayerScore(wyg,score,true)
for name, player in pairs(tfm.get.room.playerList) do
tablica[name]=0
zycie[name]=1
e=e+1
end
wyg=""
liczba=0
print(e)
else
liczba=0
end
end
function eventPlayerRespawn(nn)
if(zycie[nn]==0) then
tfm.exec.setVampirePlayer(nn)
end
end