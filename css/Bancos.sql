-- Bancos.sql hecho en PostgresSQL

--EJER 2 PRACTICA 3 

-- SET SEARCH_PATH = 'bancos';


drop table if exists banco;
CREATE TABLE banco 	(cod_banco INTEGER NOT NULL, 
						 nombre VARCHAR (50),
						 precio INTEGER,
						 cotizacion_maxima INTEGER,
						 PRIMARY KEY (cod_banco));


drop table if exists cotizacion;
CREATE TABLE cotizacion 	(cod_cotizacion INTEGER NOT NULL, 
						 cod_banco INTEGER,
						 cotizacion INTEGER,
						 PRIMARY KEY (cod_cotizacion));
 						 CONSTRAINT FKbanco FOREIGN KEY (cod_banco) REFERENCES banco(cod_banco) ON DELETE CASCADE);

-- FUNCTION maxCotizacion
-- se queda con la maxima cotizacion de el banco pasado por parametro de la tabla cotizacion
-- mediante un for (no usando la funcion MAX) retorna esa maxima cotizacion y luego actualiza
-- la tabla banco en el campo cotizacion_maxima con el resultado de la funcion

CREATE OR REPLACE FUNCTION maxCotizacion(in codBanco int ) RETURNS INTEGER AS $$
	DECLARE 
		index CURSOR FOR SELECT * FROM cotizacion;
		i int;
		aux int;
		result int;

	BEGIN
		result := 0;
		FOR i in select cotizacion from cotizacion WHERE cod_banco = codBanco loop
			aux := i;
			if (aux>result) then 
				result := aux;
			end if;	
		END LOOP;
		UPDATE banco SET cotizacion_maxima = result WHERE cod_banco = codBanco;		 
		RETURN result;
	END;
	$$ LANGUAGE 'plpgsql';


--INSERT

insert into banco(cod_banco,nombre,precio,cotizacion_maxima) values (1,'coco',10,10);
insert into banco(cod_banco,nombre,precio,cotizacion_maxima) values (2,'cucu',5,5);	

insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (1,1,11);	
insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (2,1,7);	
insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (3,1,15);	
insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (3,1,14);	

insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (4,2,4);		
insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (5,2,7);	
insert into cotizacion(cod_cotizacion,cod_banco,cotizacion) values (6,2,10);		