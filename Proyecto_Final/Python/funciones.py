import mysql.connector
from mysql.connector import Error

# --- CONFIGURACIÓN DE CONEXIÓN ---
def conectar():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='sistema_ventas',
            user='root',
            password='admin'  
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error de conexión: {e}")
        return None

# --- FUNCIONES DE PRODUCTOS ---
def ver_productos():
    """Llama al procedimiento 'ver_productos' y retorna la lista de datos."""
    conn = conectar()
    lista_productos = [] 
    
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('ver_productos')
            
            for result in cursor.stored_results():
                lista_productos = result.fetchall()
                
        except Error as e:
            print(f"Error al obtener productos: {e}")
        finally:
            cursor.close()
            conn.close()
            
    return lista_productos

def agregar_producto(nombre, precio, stock, categoria):
    """Llama al procedimiento 'agregar_producto' para guardar datos."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('agregar_producto', [nombre, precio, stock, categoria])
            
            conn.commit() 
            print("¡Producto registrado exitosamente!")
            return True
        except Error as e:
            print(f"Error al registrar producto: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

def editar_producto(id_producto,nombre, precio, stock, categoria):
    """Verifica si el ID existe y luego llama al procedimiento 'actualizar_producto'."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            
            existe_id = "SELECT COUNT(*) FROM Producto WHERE id_producto = %s"
            cursor.execute(existe_id, (id_producto,))
            
            # Obtenemos el resultado (si es 0, no existe)
            resultado = cursor.fetchone()[0]
            if resultado == 0:
                print(f"ERROR: El producto con ID {id_producto} NO existe.")
                return False 
            
            cursor.callproc('actualizar_producto', [id_producto, nombre, precio, stock, categoria])
            conn.commit() 
            print("¡Producto editado exitosamente!")
            return True

        except Error as e:
            print(f"Error al editar producto: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

def eliminar_producto(id_producto):
    """Llama al procedimiento 'eliminar_producto'."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            
            existe_id = "SELECT COUNT(*) FROM Producto WHERE id_producto = %s"
            cursor.execute(existe_id, (id_producto,))
            
            resultado = cursor.fetchone()[0]
            if resultado == 0:
                print(f"ERROR: El producto con ID {id_producto} NO existe.")
                return False 
            
            cursor.callproc('eliminar_producto', [id_producto])
            conn.commit()
            print("¡Producto eliminado exitosamente!")
            return True

        except Error as e:
            # El código 1451 es el error de Foreign Key Constraint
            if e.errno == 1451:
                print("ERROR: No se puede eliminar este producto porque tiene ventas asociadas.")
            else:
                print(f"Error al eliminar: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

def obtener_producto_mas_vendido():
    """Llama al procedimiento 'reportar_producto' y devuelve el top 1 en ventas."""
    conn = conectar()
    resultado = None
    
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('reportar_producto')
            
            for result in cursor.stored_results():
                resultado = result.fetchone() 
            
        except Error as e:
            print(f"Error al generar reporte: {e}")
        finally:
            cursor.close()
            conn.close()
            
    return resultado

# --- FUNCIONES DE CLIENTES ---
def agregar_cliente(dni,nombre, apellido, email, telefono, direccion):
    """Llama al procedimiento 'agregar_cliente' para guardar datos."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('agregar_cliente', [dni,nombre, apellido, email, telefono, direccion])
            
            conn.commit() 
            print("Cliente registrado exitosamente!")
            return True
        except Error as e:
            print(f"Error al registrar cliente: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

def ver_clientes():
    """Llama al procedimiento 'ver_clientes' y retorna la lista de datos."""
    conn = conectar()
    lista_clientes = [] 
    
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('ver_clientes')
            
            for result in cursor.stored_results():
                lista_clientes = result.fetchall()
                
        except Error as e:
            print(f"Error al obtener clientes: {e}")
        finally:
            cursor.close()
            conn.close()
            
    return lista_clientes

def editar_cliente(dni,nombre, apellido, email, telefono, direccion):
    """Verifica si el DNI existe y luego llama al procedimiento 'actualizar_cliente'."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            
            existe_dni = "SELECT COUNT(*) FROM Cliente WHERE dni_cliente = %s"
            cursor.execute(existe_dni, (dni,))
            
            # Obtenemos el resultado (si es 0, no existe)
            resultado = cursor.fetchone()[0]
            if resultado == 0:
                print(f"ERROR: El cliente con DNI {dni} NO existe.")
                return False 
            
            cursor.callproc('actualizar_cliente', [dni,nombre, apellido, email, telefono, direccion])
            conn.commit() 
            print("Cliente editado exitosamente!")
            return True

        except Error as e:
            print(f"Error al editar cliente: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

def obtener_ordenes_por_cliente(dni_cliente):
    """Llama al procedimiento 'obtenerOrdenesCliente' y devuelve el historial de compras."""
    conn = conectar()
    lista_ordenes = []
    
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('obtenerOrdenesCliente', [dni_cliente])
            
            for result in cursor.stored_results():
                lista_ordenes = result.fetchall()
                
        except Error as e:
            print(f"Error al obtener órdenes: {e}")
        finally:
            cursor.close()
            conn.close()
            
    return lista_ordenes

def ajustar_limite_compra(id_prod, max_cantidad):
    """Llama al procedimiento 'ajustar_limite_ordenes'."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('ajustar_limite_ordenes', [id_prod, max_cantidad])
            conn.commit() 
            
            mensaje_bd = ""
            for result in cursor.stored_results():
                fila = result.fetchone()
                if fila:
                    mensaje_bd = fila[0] 
            
            print(f"Reporte de la Base de Datos: {mensaje_bd}")
            return True
        except Error as e:
            print(f"Error al ajustar límites: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

def registrar_nueva_venta(dni_cliente, id_producto, cantidad):
    """Intenta registrar una venta. Retorna True si hubo stock, False si no."""
    conn = conectar()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('registrar_venta', [dni_cliente, id_producto, cantidad])
            conn.commit()

            if cursor.rowcount > 0:
                print("¡Venta registrada exitosamente!")
                return True
            else:
                print("No se pudo registrar la venta.")
                print("Error: Stock insuficiente o Producto no encontrado.")
                return False

        except Error as e:
            print(f"Error de base de datos: {e}")
            return False
        finally:
            cursor.close()
            conn.close()

# --- FUNCIONES DE BÚSQUEDA ---
def buscar_productos_por_texto(texto_busqueda):
    """Llama al procedimiento 'buscar_productos' para filtrar por nombre o categoría."""
    conn = conectar()
    resultados = []
    
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('buscar_productos', [texto_busqueda])
            
            for result in cursor.stored_results():
                resultados = result.fetchall()
                
        except Error as e:
            print(f"Error en búsqueda de productos: {e}")
        finally:
            cursor.close()
            conn.close()
    return resultados

def buscar_clientes_por_texto(texto_busqueda):
    """Llama al procedimiento 'buscar_clientes' para filtrar por nombre, apellido o email."""
    conn = conectar()
    resultados = []
    
    if conn:
        try:
            cursor = conn.cursor()
            cursor.callproc('buscar_clientes', [texto_busqueda])
            
            for result in cursor.stored_results():
                resultados = result.fetchall()
                
        except Error as e:
            print(f"Error en búsqueda de clientes: {e}")
        finally:
            cursor.close()
            conn.close()
    return resultados