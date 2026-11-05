# codis_postals


## Com ha anat l'experiència?

Cada vegada que començo un flutter nou organitzo bé l'estructura de fitxers des del principi (separant models, pantalles i estils) tal com vam fer al Receptari i aixi vec tot amb més calredat. L'ús d'una classe centralitzada `AppStyles` va bé per no repetir estils de text i colors a cada fitxer.

### Què m'ha sortit bé i què ha costat més?

- El que m'ha anat bé: La generació dels models amb Quicktype ha simplificat molt la lectura del JSON. Gestionar el cas quan la clau `results` no existeix (per exemple cercant `99999`) al principi despistava una mica, però amb una condició ternària l'he pogut fer.
- El que m'ha costat més: Assegurar-me que dades opcionals com la població o la llista de codis postals no fessin fallar l'app en poblacions petites (com Sant Pere de Reixac). Afegir els tipus anul·lables `int?` i `List<String>?` ho ha solucionat completament. I lo de sempre que se m'oblida posar "[] , {} o , " no es que em costi es per oblit.

### Què he après?

He après a controlar de forma robusta diferents estats de la interfície d'usuari (càrrega, èxit, llista buida i errors de xarxa posant l'emulador en mode avió) i a passar objectes entre pantalles per mostrar una vista de detall completa amb `Wrap` i `Chip`.

### Què canviaria o faria si tingués més temps?

Si hagués de continuar millorant-la, m'agradaria implementar el Repte per afegir la predicció meteorològica en temps real a la pantalla de detall i desar les cerques recents a la memòria del dispositiu.