------------------------------------------------------------------
General Idea Behind This Software
------------------------------------------------------------------
Peer-to-peer (“P2P”) technology was first widely deployed and
popularized by file-sharing applications such as Napster and
KaZaA. In this context, P2P technology allows users to share,
search for and download files. The P2P moniker has been widely
used and just as often abused. Companies both large and small,
self-proclaimed “pundits” and others to trying to cash in on the
“P2P buzz” use this term as long as it involves some direct
communication between users or nodes. This description of P2P
completely misses the point.

A true P2P system, in our opinion, is one where all nodes in a
network join together dynamically to participate in traffic
routing-, processing- and bandwidth intensive tasks that would
otherwise be handled by central servers.

A true P2P application empowers small teams with good ideas to
develop software and businesses that can successfully challenge
those of large companies. True P2P, when applied to ripe markets,
is disruptive technology.

------------------------------------------------------------------
My Concept of P2P And How I Displayed It In This Software
------------------------------------------------------------------
When I first started this project, I had a few problems. One of
them was, "How in the heck do I, as a client that knows nobody on
the network, find someone that is on the network?" I was
dumbfounded, I wondered how KaZaA did it, as well as Gnutella and
Overnet.

I did a little research and found that they were very smart about
it, it is not as complicated as one would think. Your KaZaA or
whatever you download comes with a list of people already on the
network! You load that file up and it tells you a few people to
connect to, then you work you way from there, getting IP's from
everyone you can possibly get. Every time you meet a new
connection on the network, they tell you everyone they know, and
you do likewise.

My software is a very small implementation of this idea, however
it can be expanded fairly eaily. So, let's get on to geting
started with this application, so you can see how it really works.

I have commented as best I can, and provided as much information
as I could possibly provide off the top of my head to make this
a learning experience and not some frustrating endeavor.

------------------------------------------------------------------
Getting Started With This Application
------------------------------------------------------------------
Go into the folder called "code" and execute the Visual Basic
Project file, it will open up the messenger. You need not change
anything at this point in the code, just click on File>Make EXE
and compile it to the folder called "compile here".

Close the VB Project, as you do not need it open at the moment.

Go to the folder called "compile here" and go to its sub-folder
called "config" and open the file called p2p.ini.

Edit the following if required:

[Connection Settings]
LocalPort = 4672

Close the ini file and save it, move up to the parent folder.

Execute the exe file, once you execute it your computer becomes
a server listening for active connections. You are able to
connect to yourself, so go ahead and click BOOT. Your local IP
address should already be in the box as 127.0.0.1 and you will
notice that a number 1 appears both in the client and host
lists. Those are you, those represent you both as a client and
as a host. A host is a server.

When you are on a P2P network you act both as a server and a
client, that makes you a "node" and allows you to pass traffic
through yourself. It allows people to both connect to you and
you to connect to other people effortlessly.

Click on the number 1 in the client list, then type a message
in the send message box and click the CLIENT button. You will
notice in the messages box that your message appears twice,
both to and from. If you were to send the message to a remote
computer, you would not see the from; however if someone sent
you a message it would appear as from, and you would not see
the to.

You can connect to yourself, and anyone else as many times
as you choose, and vise-versa. Anyone can connect to you that
has the same program running. Give it to your friends and try
it out, you can all be connected to eachother, at the moment
the only way that I have implemented for you to connect to
anyone else is the BOOT button so you will have to use that
every time to connect to a new person.

You will notice when you connect to someone, that they send
you some IP addresses and ports, they are sharing with you
everyone that they know of that exists on the network. You
can use that to your advantage and connect to every IP that
you see there.

If you feel up to it, you can create your own P2P program
from this one that automatically connects to those IP
addresses so that you can have the true p2p feel.

Well, now you know enough to play with it. That is about all
that I can think of at the moment, however this application
has some very powerful potential if you are willing to put
it to use.
------------------------------------------------------------------

Thank you for taking the time to look at my app. You are welcome to
email me if you feel you have any questions, etc.

My email is: theaxiom@charter.net