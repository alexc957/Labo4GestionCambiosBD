create table #tmp(
codped varchar(3),
nuevo_cod varchar(7))

create table #tmp1
(
valor varchar(2)
)
insert into #tmp1
select dbo.change_key(codped) from movimiento.CabezeraP
insert into #tmp
select codped, CONCAT( 'PE', dbo.check_lenght(dbo.change_key(codped)),dbo.change_key(codped))
from movimiento.CabezeraP where codped='r99'

select dbo.change_key(codped) from movimiento.CabezeraP
drop function dbo.change_key 
CREATE FUNCTION dbo.change_key
(@strAlphaNumeric varCHAR(3))
RETURNS CHAR(2)
AS
BEGIN
DECLARE @intAlpha INT
SET @intAlpha = PATINDEX('%[^1-9]%', @strAlphaNumeric)
BEGIN
WHILE @intAlpha > 0
BEGIN
	SET @strAlphaNumeric = STUFF(@strAlphaNumeric, @intAlpha, 1, '' );
	SET @intAlpha = PATINDEX('%[^1-9]%', @strAlphaNumeric );			
END
END
RETURN ISNULL(@strAlphaNumeric,0)
END
GO

select * from #tmp1
UPDATE
    Table_A
SET
    Table_A.codcli = Table_B.nuevo_cod
FROM
    catalogo.CLIENTE as Table_A
    INNER JOIN #tmp AS Table_B
        ON Table_A.codcli = Table_B.cod_cliente
UPDATE
    Table_A
SET
    Table_A.garante = Table_B.nuevo_cod
FROM
    catalogo.CLIENTE as Table_A
    INNER JOIN #tmp AS Table_B
        ON Table_A.garante = Table_B.cod_cliente

DROP FUNCTION dbo.check_lenght

CREATE FUNCTION dbo.check_lenght 
(@strAlphaNumeric CHAR(2))
returns char(7)
AS
BEGIN
DECLARE @strZero char(7)
IF len(@strAlphaNumeric)=1
BEGIN
	SET @strZero='0000000'
END
ELSE
BEGIN
	SET @strZero='000000'
END
RETURN ISNULL(@strZero,0)
END
select * from movimiento.CabezeraP
inseRT INTO movimiento.cabezerap values ('R99','2018/10/02',NULL,'C00001')
select len(valor) from #tmp1