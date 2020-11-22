# Administración y Diseño de Bases de Datos - Grupo 10
Componentes del Grupo:

 **Chesen Castilla Gil** - alu0101046853@ull.edu.es

 **Néstor Torres Díaz** - alu0101021768@ull.edu.es
 
 **Edgar Figueroa González** - alu0101043838@ull.edu.es

## Práctica 1: Presentación Supuesto Proyecto de Bases de Datos

- PDF con el Supuesto : [Supuesto Práctico](/documentos/supuesto.pdf)

## Práctica 2: Diseño Viveros

- PDF descriptivo: [Descripción](/documentos/viveros.pdf)
- Esquema E/R(.drawio): [Esquema](/pract02/viveros.drawio)
![imágenio](/pract02/vivero.png)

## Práctica 3: Diseño Barco

- PDF descriptivo: [Descripción](/documentos/barco.pdf)
- Esquema E/R(.drawio): [Esquema](/pract03/barco.drawio)
![imagenbarco](/pract03/barco.png)

## Práctica 4: Modelo Lógico Relacional

### Catastro

- Script Catastro: [Script](/pract04/catastro.sql)
- Modelo WorkBench Catastro: [Modelo](/pract04/catastro.mwb)
![imagencatastro](/pract04/catastro.png)

### Vivero

- Script Vivero: [Script](/pract04/viveros.sql) 
- Modelo WorkBench Vivero: [Modelo](/pract04/viveros.mwb) 
![imagenviveros](/pract04/viveros.png)

## Práctica 5: Triggers

- Script Vivero con triggers: [Script](/pract05/viveros.sql)
- Script Catastro con triggers: [Script](/pract05/catastro.sql)

### Procedure

- Una función procedure en mysql para genererar un correo electronico.

 ```sql
    CREATE PROCEDURE crear_email(IN nombre_cliente VARCHAR(45), IN id_persona VARCHAR(45), IN code varchar(45), IN dominio VARCHAR(24), OUT nuevo_email VARCHAR(45)) 
    BEGIN
    SET nuevo_email = CONCAT(nombre_cliente,code,'@',dominio);
    END;
``` 

### Triggers

- Trigger para generar un correo cuando no se especifique.
~~~~sql
    CREATE TRIGGER trigger_crear_email_before_insert BEFORE INSERT ON viveros.Cliente
    FOR EACH ROW
    BEGIN
    IF (NEW.email IS NULL) THEN
    CALL crear_email(new.nombre, new.dni, new.codigo, 'ull.edu.es', NEW.email);
    END IF;
    END; 
~~~~
- Trigger para no permitir que una persona viva en más de una ubicación.

```sql
    CREATE TRIGGER vivienda_unica_insert BEFORE INSERT ON catastro.Persona 
    FOR EACH ROW
    BEGIN
    IF (new.Vivienda_calle IS NOT NULL AND new.Piso_Bloque_calle IS NOT NULL) THEN
        signal sqlstate '45000' set message_text = 'Una persona no puede vivir en dos viviendas';
    END IF;
    END;

    CREATE TRIGGER vivienda_unica_update BEFORE UPDATE ON catastro.Persona 
    FOR EACH ROW
    BEGIN
    IF (new.Vivienda_calle IS NOT NULL AND new.Piso_Bloque_calle IS NOT NULL) THEN
        signal sqlstate '45000' set message_text = 'Una persona no puede vivir en dos viviendas';
    END IF;
    END;
```
    
- Trigger para actualizar automáticamente el stock de un producto.

```sql
    CREATE TRIGGER trigger_actualizar_stock AFTER INSERT ON viveros.Pedido_has_Producto
    FOR EACH ROW
    BEGIN
        UPDATE Producto SET stock = stock - new.cant_prod WHERE new.Producto_cod_prod = cod_prod;
    END;
```



