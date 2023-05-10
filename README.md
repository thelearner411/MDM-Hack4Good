# Hackathon For Good: La Región de AWS en España al Servicio de la Sociedad

## Descripción del Proyecto

Mejor de Mira es una aplicación móvil para Android que ayuda a las personas personas con discapacidad visual a navegar por los supermercados con la asistencia de servicios de voz.

<img src="https://github.com/thelearner411/MDM/blob/main/mas_de_mira/assets/mejor-de-mira-screen.png" alt="Mejor de Mira Screen" style="display: block; margin: auto;"/>

## Diagrama de Arquitectura

Mejor de Mira fue programado en el lenguaje Dart usando el SDK de Flutter.

En esta sección podéis realizar una descripción más detallada de vuestra aplicación/solución, indicando el caso de uso, los pros y contras de vuestra implementación, etc.

Adjuntar una imagen del diagrama de arquitectura de la solución.

## Descripción Técnica

## Lenguaje de Programación

Mejor de Mira fue programado en el lenguaje Dart usando el SDK de Flutter.


## Los Servicios de AWS

Utilizamos varios servicios de AWS para facilitar el proceso:

- <b>Amazon Recognition</b> para entrenar productos y recibir sus etiquetas.
- <b>Amazon S3 Bucket</b> para guardar las imágenes de los productos para el entrenamiento de Rekognition y también para almacenar imágenes de los productos capturadas por el usuario.
- <b>Amazon API Gateway</b>
  - para hacer una solicitud PUT cuando el usuario captura una foto de un producto que se carga en el S3 bucket.
  - para hacer una solicitud GET y recibir la etiqueta precedida de la imagen capturada usando el modelo entrenado con Rekognition.
- <b>Amazon Polly</b>
  - para repetir en voz alta una lista predefinida por el usuario.
  - pra decir la etiqueta de un producto escaneado.

## Demo Vídeo

Dale click a la imagen abajo para ver la presentación en video.

[![Mira la presentación en video](https://github.com/thelearner411/MDM/blob/dev/assets/MDM-video-screenshot.png)](https://www.youtube.com/watch?v=yB8JMReQRIU "MDM - Presentación en Video")


## Team Members

Doris Menard: dorismenard@alumni.ie.edu

Mateo Vizuete: mateovizuete@gmail.com

Mikhaile Collins: collinsinfospot@gmail.com
