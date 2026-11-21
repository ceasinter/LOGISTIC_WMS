# LOGISTIQ WMS
### Plataforma de Gestión de Almacenes y Cadena de Suministro

**LOGISTIQ WMS** es un sistema modular de gestión de almacenes (WMS) diseñado para optimizar las operaciones logísticas, el control de inventarios y la trazabilidad de los procesos de la cadena de suministro.

El proyecto está siendo desarrollado utilizando **SAP ABAP Cloud y el modelo de programación RESTful (RAP)**, siguiendo las prácticas modernas de desarrollo del ecosistema SAP.

Su objetivo principal es construir una solución logística realista y demostrar la aplicación práctica de tecnologías SAP en el desarrollo de software empresarial.

---

## Visión del proyecto

LOGISTIQ busca ofrecer una plataforma integral para gestionar las operaciones de almacén, desde la recepción de mercancías hasta el despacho y la entrega final.

La plataforma tendrá una arquitectura modular que permitirá gestionar diferentes procesos logísticos mediante aplicaciones funcionales independientes, compartiendo datos y servicios comunes.

La visión a largo plazo contempla:

- Gestión de almacenes y centros de distribución.
- Control y trazabilidad de inventarios.
- Recepción de mercancías.
- Ubicación y almacenamiento de productos (Putaway).
- Transferencias y reposición de existencias.
- Preparación de pedidos (Picking).
- Embalaje y consolidación (Packing).
- Gestión de pallets y unidades de manipulación (Handling Units).
- Conteos cíclicos e inventarios físicos.
- Despachos y seguimiento de entregas.
- Paneles de control e indicadores operativos.
- Integración con SAP y otros sistemas ERP.

## Tecnologías utilizadas

| Tecnología | Aplicación |
|---|---|
| SAP BTP ABAP Environment | Plataforma de desarrollo en la nube |
| ABAP Cloud | Desarrollo del backend |
| SAP RAP | Modelo de programación y servicios transaccionales |
| CDS View Entities | Modelado de datos |
| OData V4 | Exposición de servicios |
| SAP Fiori Elements | Interfaz de usuario |
| Eclipse ADT | Entorno de desarrollo |
| GitHub | Control de versiones y documentación |

## Arquitectura del sistema

LOGISTIQ utiliza una arquitectura modular basada en SAP RAP.

```text
LOGISTIQ WMS
│
├── CORE
│   ├── Gestión de estados
│   ├── Gestión de procesos
│   └── Auditoría y trazabilidad
│
├── DATOS MAESTROS
│   ├── Almacenes
│   ├── Ubicaciones
│   ├── Productos
│   └── Unidades de medida
│
├── RECEPCIÓN
│   ├── Recepción de mercancías
│   ├── Verificación de recepción
│   └── Almacenamiento (Putaway)
│
├── INVENTARIO
│   ├── Gestión de existencias
│   ├── Movimientos de inventario
│   ├── Transferencias
│   └── Conteos cíclicos
│
├── PICKING
│   ├── Órdenes de preparación
│   ├── Tareas de picking
│   └── Reposición
│
└── DESPACHO
    ├── Embalaje
    ├── Carga
    ├── Despacho
    └── Seguimiento de entregas
```

Cada módulo representa un dominio funcional con sus propios procesos, reglas de negocio y responsabilidades operativas.

## Principios fundamentales de diseño

### 1. Trazabilidad del inventario

Cada movimiento de inventario debe quedar registrado y ser trazable.

Las correcciones de existencias se realizarán mediante movimientos compensatorios o de reversión, evitando la eliminación de transacciones históricas.

### 2. Gestión de estados

Cada proceso de negocio tendrá su propio ciclo de estados.

Ejemplos:

- Recepción: Creada → En proceso → Finalizada.
- Almacenamiento: Pendiente → Asignado → Completado.
- Picking: Abierto → En proceso → Preparado.
- Despacho: Preparado → Cargado → Despachado.
- Entrega: En tránsito → Entregado.

Las transiciones entre estados estarán sujetas a reglas de negocio.

### 3. Auditoría

Las operaciones relevantes deberán registrar:

- Usuario responsable.
- Fecha y hora.
- Estado anterior.
- Estado nuevo.
- Referencia del proceso.
- Motivo del cambio, cuando corresponda.

### 4. Arquitectura modular

La solución estará diseñada para permitir el desarrollo de aplicaciones funcionales independientes, manteniendo entidades compartidas y reglas de negocio coherentes.

### 5. Integración con ERP

La arquitectura contempla futuras integraciones con SAP y otros sistemas ERP mediante APIs y servicios estandarizados.

---

## Objetivos del proyecto

LOGISTIQ tiene tres objetivos principales:

1. Construir una solución realista de gestión de almacenes.
2. Aplicar buenas prácticas de desarrollo con SAP ABAP Cloud y RAP.
3. Crear un portafolio profesional que demuestre experiencia práctica en desarrollo SAP.

## Posibilidades futuras

LOGISTIQ se plantea con una arquitectura que permita ampliar sus capacidades más allá de un sistema de gestión de almacenes tradicional.

Entre las funcionalidades futuras se consideran:

- Gestión de múltiples almacenes y centros de distribución.
- Operaciones móviles para personal de almacén.
- Lectura de códigos de barras y códigos QR.
- Optimización avanzada de inventarios.
- Integración con sistemas ERP externos.
- Monitoreo operativo en tiempo real.

---

## Estado del proyecto

**Desarrollo activo — Noviembre de 2026**

LOGISTIQ es un proyecto en evolución. Sus funcionalidades y arquitectura podrán ampliarse y ajustarse a medida que avance su desarrollo.

---

*LOGISTIQ WMS — Conectando operaciones de almacén, inventarios y cadena de suministro.*
