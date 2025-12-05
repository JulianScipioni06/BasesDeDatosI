import sys
import funciones

# --- FUNCIONES ---
def mostrar_productos():
        productos = funciones.ver_productos()
        
        if not productos:
            print("No se encontraron productos o hubo un error.")
            return
        
        print(f"\n{'ID':<5} {'NOMBRE':<20} {'PRECIO':<12} {'STOCK':<8} {'CATEGORÍA'}")
        print("-" * 65)
        
        for prod in productos:
            id_prod = prod[0]
            nombre = prod[1]
            stock = prod[2]
            precio = prod[3]
            cat = prod[4]
            print(f"{id_prod:<5} {nombre:<20} {precio:<11} {stock:<8} {cat}")
    
def mostrar_clientes():
        clientes = funciones.ver_clientes()
        
        if not clientes:
            print("No se encontraron clientes o hubo un error.")
            return
        
        print(f"\n{'DNI':<15} {'NOMBRE':<20} {'APELLIDO':<20} {'EMAIL':<30} {'TELEFONO':<20}{'DIRECCION'}")
        print("-" * 120)
        
        for cliente in clientes:
            dni = cliente[0]
            nombre = cliente[1]
            apellido = cliente[2]
            email = cliente[3]
            telefono = cliente[4]
            direccion = cliente[5]
            print(f"{dni:<15} {nombre:<20} {apellido:<20} {email:<30} {telefono:<20} {direccion}")

# --- FUNCIONES DEL MENÚ ---
def gestionar_productos():
    while True:
        print("\n--- GESTIÓN DE PRODUCTOS ---")
        print("1. Ver lista de productos")
        print("2. Agregar un nuevo producto")
        print("3. Actualizar un producto")
        print("4. Eliminar un producto")
        print("0. Volver al menú principal")
        
        opcion = input("Seleccione una opción: ")
        
        if opcion == '1':
            mostrar_productos()
        elif opcion == '2':
            print("\n--- NUEVO PRODUCTO ---")
            try:
                nombre = input("Nombre del producto: ")
                precio = float(input("Precio: "))
                stock = int(input("Stock inicial: "))
                categoria = input("Categoría: ")
                
                funciones.agregar_producto(nombre, precio, stock, categoria)
            except ValueError:
                print("¡Error! El precio y el stock deben ser números.")
                
        elif opcion == '3':
            print("\n--- ACTUALIZAR PRODUCTO ---")
            try:
                id_producto = int(input("Ingrese el ID del producto a editar: "))
                nombre = input("Nuevo Nombre: ")
                precio = float(input("Nuevo Precio: "))
                stock = int(input("Nuevo Stock inicial: "))
                categoria = input("Nueva Categoría: ")
                
                funciones.editar_producto(id_producto,nombre, precio, stock, categoria)
            except ValueError:
                print("¡Error! El precio y el stock deben ser números.")
        
        elif opcion == '4':
            print("\n--- ELIMINAR PRODUCTO ---")
            try:
                id_prod = int(input("Ingrese el ID del producto a eliminar: "))
                funciones.eliminar_producto(id_prod)
                
            except ValueError:
                print("¡Error! El ID debe ser un número.")
        elif opcion == '0':
            break 
        else:
            print("Opción inválida.")

def gestionar_clientes():
    while True:
        print("\n--- GESTIÓN DE CLIENTES ---")
        print("1. Ver lista de clientes")
        print("2. Agregar un nuevo cliente")
        print("3. Editar un cliente")
        print("0. Volver al menú principal")
        
        opcion = input("Seleccione una opción: ")
        
        if opcion == '1':
            mostrar_clientes()
        elif opcion == '2':
            print("\n--- NUEVO CLIENTE ---")
            try:
                dni = int(input("DNI del Cliente: "))
                nombre = input("Nombre del cliente: ")
                apellido = input("Apellido del cliente: ")
                email = input("Email del Cliente: ")
                telefono = input("Telefono: ")
                direccion = input("Direccion: ")
                
                funciones.agregar_cliente(dni,nombre, apellido, email, telefono, direccion)
            except ValueError:
                print("¡Error! DNI debe ser un entero")
                
        elif opcion == '3':
            print("\n--- EDITAR CLIENTE ---")
            try:
                dni = int(input("DNI del Cliente a Editar: "))
                nombre = input("Nuevo Nombre: ")
                apellido = input("Nuevo Apellido: ")
                email = input("Nuevo Email: ")
                telefono = input("Nuevo Telefono: ")
                direccion = input("Nueva Direccion: ")
                
                funciones.editar_cliente(dni,nombre, apellido, email, telefono, direccion)
            except ValueError:
                print("¡Error! DNI debe ser un entero")
        
        elif opcion == '4':
            print("\n--- ELIMINAR PRODUCTO ---")
            try:
                id_prod = int(input("Ingrese el ID del producto a eliminar: "))
                funciones.eliminar_producto(id_prod)
                
            except ValueError:
                print("¡Error! El ID debe ser un número.")
        elif opcion == '0':
            break 
        else:
            print("Opción inválida.")

def procesar_ordenes():
    while True:
        print("\n--- PROCESAMIENTO DE ÓRDENES ---")
        print("1. Registrar Nueva Venta")
        print("2. Ver Historial de un Cliente")
        print("0. Volver atrás")
        
        opcion = input("Seleccione una opción: ")
        
        if opcion == '0':
            break
            
        elif opcion == '1': # NUEVA VENTA
            print("\n--- NUEVA VENTA ---")
            try:
                dni = int(input("DNI del Cliente: "))
                id_producto = int(input("ID del Producto: "))
                cant = int(input("Cantidad a vender: "))
                
                if cant > 0:
                    funciones.registrar_nueva_venta(dni, id_producto, cant)
                else:
                    print("La cantidad debe ser mayor a 0.")
                    
            except ValueError:
                print("Error: Todos los datos deben ser números enteros.")

        elif opcion == '2': # VER HISTORIAL
            try:
                dni = int(input("\nIngrese el DNI del cliente a consultar: "))
                ordenes = funciones.obtener_ordenes_por_cliente(dni)
                
                if not ordenes:
                    print(f"No se encontraron órdenes para el cliente {dni}.")
                else:
                    nombre_completo = f"{ordenes[0][0]} {ordenes[0][1]}" 
                    print(f"\nCliente: {nombre_completo}")
                    print("-" * 75)
                    print(f"{'FECHA':<12} {'ID ORDEN':<10} {'PRODUCTO':<30} {'CANTIDAD'}")
                    print("-" * 75)
                    for ord in ordenes:
                        print(f"{str(ord[3]):<12} {ord[2]:<10} {ord[4]:<30} {ord[5]}")
            except ValueError:
                print("Error: El DNI debe ser un número.")
        
        else:
            print("Opción inválida.")

def busquedas_avanzadas():
    while True:
        print("\n--- BÚSQUEDAS AVANZADAS ---")
        print("1. Buscar Productos")
        print("2. Buscar Clientes")
        print("0. Volver atrás")
        
        opcion = input("Seleccione qué desea buscar: ")
        
        if opcion == '0':
            break
            
        elif opcion == '1': # BUSCAR PRODUCTOS
            texto = input("\nIngrese nombre o categoría a buscar: ")
            resultados = funciones.buscar_productos_por_texto(texto)
            
            if resultados:
                print(f"\n--- Resultados para '{texto}' ---")
                print(f"{'ID':<5} {'PRODUCTO':<25} {'CATEGORÍA':<15} {'PRECIO'}")
                print("-" * 60)
                for p in resultados:
                    print(f"{p[0]:<5} {p[1]:<25} {p[4]:<15} ${p[3]}")
            else:
                print("No se encontraron productos con ese criterio.")
        
        elif opcion == '2': # BUSCAR CLIENTES
            texto = input("\nIngrese nombre, apellido o email a buscar: ")
            resultados = funciones.buscar_clientes_por_texto(texto)
            
            if resultados:
                print(f"\n--- Resultados para '{texto}' ---")
                print(f"{'DNI':<10} {'NOMBRE Y APELLIDO':<30} {'EMAIL'}")
                print("-" * 70)
                for c in resultados:
                    nombre_completo = f"{c[1]} {c[2]}"
                    print(f"{c[0]:<10} {nombre_completo:<30} {c[3]}")
            else:
                print("No se encontraron clientes con ese criterio.")
        else:
            print("Opción inválida.")

def reporte_ventas():
    print("REPORTE DE PRODUCTO MAS VENDIDO")
    print("-"*60)
    
    top_producto = funciones.obtener_producto_mas_vendido()
    if top_producto:
        id_producto = top_producto[0]
        nombre = top_producto[1]
        total = top_producto[2]
        
        print(f"EL PRODUCTO MÁS VENDIDO ES:")
        print(f"   Nombre: {nombre}")
        print(f"   ID:     {id_producto}")
        print(f"   Total Unidades Vendidas: {total}")
        print("-" * 60)
    else:
        print("\nNo hay suficientes datos de ventas para generar el reporte.")

def modificar_limite_producto():
    print("MODIFICACIÓN MASIVA DE LÍMITES DE COMPRA")
    print("-" * 50)
    print("Esta acción buscará TODAS las órdenes de un producto y si")
    print("superan la cantidad máxima, las reducirá a ese límite.")
    print("El stock se devolverá automáticamente al inventario.")
    print("-" * 50)

    try:
        id_producto = int(input("Ingrese el ID del producto a limitar: "))
        cantidad_max = int(input("Ingrese la cantidad MÁXIMA permitida por compra: "))
        
        if cantidad_max < 1:
            print("Error: La cantidad debe ser al menos 1.")
            return
        funciones.ajustar_limite_compra(id_producto, cantidad_max)
    except ValueError:
        print("¡Error! Debe ingresar números enteros.")

def menu_principal():
    while True:
        print("\n" + "="*40)
        print("   SISTEMA DE VENTAS - PROYECTO FINAL")
        print("="*40)
        print("1. Gestión de Productos")
        print("2. Gestión de Clientes")
        print("3. Gestion de Ordenes")
        print("4. Busquedas Avanzadas")
        print("5. Reportar Producto mas Vendido")
        print("6. Ajustar limite de Ordenes")
        print("0. Salir")
        
        opcion = input("\nIngrese una opción: ")

        if opcion == '1':
            gestionar_productos()
        elif opcion == '2':
            gestionar_clientes()
        elif opcion == '3':
            procesar_ordenes()
        elif opcion == '4':
            busquedas_avanzadas()
        elif opcion == '5':
            reporte_ventas()
        elif opcion == '6':
            modificar_limite_producto()
        elif opcion == '0':
            print("¡Hasta luego!")
            sys.exit()
        else:
            print("Opción no válida.")

if __name__ == "__main__":
    menu_principal()