drop database if exists kolokvij_vjezba_9;
create database kolokvij_vjezba_9;
use kolokvij_vjezba_9;

create table punac(
	sifra int not null primary key auto_increment,
	narukvica int not null,
	modelnaocala varchar(30),
	kuna decimal(12,8),
	bojaociju varchar(33),
	suknja varchar(45)
);

create table prijateljica(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	novcica decimal(16,7),
	kuna decimal(14,10) not null,
	drugiputa datetime,
	haljina varchar(45),
	kratkamajica varchar(49)
);

create table punac_prijateljica(
	sifra int not null primary key auto_increment,
	punac int not null,
	prijateljica int not null
);

create table cura(
	sifra int not null primary key auto_increment,
	vesta varchar(49) not null,
	ekstrovertno bit,
	carape varchar(37),
	suknja varchar(37) not null,
	punac int not null
);

create table brat(
	sifra int not null primary key auto_increment,
	novcica decimal(18,9) not null,
	ekstrovertno bit,
	vesta varchar(32) not null,
	cura int
);

create table zarucnik(
	sifra int not null primary key auto_increment,
	gustoca decimal(17,6),
	haljina varchar(40),
	kratkamajica varchar(48) not null,
	nausnica int not null,
	brat int not null
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	modelnaocala varchar(34) not null,
	suknja varchar(32),
	eura decimal(18,7)not null,
	lipa decimal(15,7) not null,
	treciputa datetime not null,
	drugiputa datetime not null
);

create table snasa(
	sifra int not null primary key auto_increment,
	prstena int,
	drugiputa datetime not null,
	haljina varchar(38) not null,
	ostavljena int
);

alter table snasa add foreign key (ostavljena) references ostavljena(sifra);

alter table zarucnik add foreign key (brat) references brat(sifra);

alter table brat add foreign key (cura) references cura(sifra);

alter table cura add foreign key (punac) references punac(sifra);

alter table punac_prijateljica add foreign key (punac) references punac(sifra);
alter table punac_prijateljica add foreign key (prijateljica) references prijateljica(sifra);

#U tablice brat, cura i punac_prijateljica unesite po 3 retka.

insert into punac(narukvica)
values(10),(15),(21);

insert into prijateljica(kuna)
values(22.22),(55.55),(88.77);

insert into punac_prijateljica(punac,prijateljica)
values(1,1),(2,2),(3,3);

insert into cura(vesta,suknja,punac)
values('Adidas','proljetna',1),('Nike','kratka',2),('Sportska','duga',3);

insert into brat(novcica,vesta)
values(33.33,'Adidas'),(45.43,'Nike'),(65.98,'Reebok');

#U tablici snasa postavite svim zapisima kolonu drugiputa na vrijednost 24. travnja 2020.
update snasa set drugiputa = '2020-04-24';

#U tablici zarucnik obrišite sve zapise čija je vrijednost kolone haljina jednako AB.
delete from zarucnik where haljina = 'AB';

#Izlistajte carape iz tablice cura uz uvjet da vrijednost kolone ekstroventno nepoznate.
select carape from cura where ekstrovertno is null;

/*Prikažite kuna iz tablice prijateljica, nausnica iz tablice zarucnik te
ekstroventno iz tablice brat uz uvjet da su vrijednosti kolone
ekstroventno iz tablice cura poznate te da su vrijednosti kolone
modelnaocala iz tablice punac sadrže niz znakova ba. Podatke
posložite po ekstroventno iz tablice brat silazno.*/

#prijateljica,zarucnik, brat, cura, punac
select p.kuna , z.nausnica , b.ekstrovertno 
from prijateljica p inner join punac_prijateljica pp on p.sifra = pp.prijateljica 
inner join punac p2 on p2.sifra = pp.punac 
inner join cura c on c.punac = p2.sifra 
inner join brat b on b.cura = c.sifra 
inner join zarucnik z on z.brat = b.sifra 
where c.ekstrovertno is not null and p2.modelnaocala like '%ba%'
order by b.ekstrovertno desc;

#Prikažite kolone modelnaocala i kuna iz tablice punac čiji se primarni ključ ne nalaze u tablici punac_prijateljica.
select p.modelnaocala , p.kuna 
from punac p inner join punac_prijateljica pp on pp.punac = p.sifra 
where pp.punac is null;















