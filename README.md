# Mapa de Emergencia · Sismo Venezuela

Mapa ciudadano en tiempo real con acceso libre: reportar y consultar personas
desaparecidas, colapsos, daños y puntos de ayuda. Hecho con HTML + Leaflet +
Supabase. Se sube a Netlify en minutos.

```
public/
  index.html      ← la app completa
  config.js       ← tus 2 claves de Supabase (editar)
supabase_setup.sql ← pegar en el SQL Editor de Supabase
netlify.toml       ← config de Netlify (no tocar)
```

---

## PASO 1 — Supabase (la base de datos compartida) · ~5 min

1. Entra a https://supabase.com → **Sign in** (con GitHub o email).
2. **New project**. Ponle nombre (ej. `sismo-venezuela`), una contraseña de DB
   (guárdala), región **East US**. Crear. Espera ~1 min a que arranque.
3. Menú izquierdo → **SQL Editor** → **New query**.
4. Abre el archivo `supabase_setup.sql`, copia TODO, pégalo y dale **Run**
   (botón verde). Debe decir *Success*.
5. Menú izquierdo → **Project Settings** (⚙️) → **API**. Copia dos cosas:
   - **Project URL** (ej. `https://xxxx.supabase.co`)
   - **anon public** key (la larga; NO la `service_role`)
6. Abre `public/config.js` y pega ahí tus dos valores. Guarda.

---

## PASO 2 — Subir a Netlify · ~3 min

### Opción A — sin terminal (arrastrar y soltar, lo más rápido)
1. Entra a https://app.netlify.com → inicia sesión.
2. Arrastra **solo la carpeta `public`** a la zona "drag and drop your site".
3. Listo: te da una URL `algo.netlify.app`. Ya funciona.
   > Para cambiar el nombre: Site configuration → Change site name.

### Opción B — con terminal (Netlify CLI)
```bash
npm install -g netlify-cli
cd sismo-app
netlify deploy --prod --dir=public
```
Sigue el login en el navegador y al final te da la URL de producción.

### Opción C — con GitHub (deploy automático en cada cambio)
```bash
cd sismo-app
git init && git add . && git commit -m "primer deploy"
# crea un repo vacío en github.com y luego:
git remote add origin https://github.com/TU_USUARIO/sismo-venezuela.git
git push -u origin main
```
En Netlify: **Add new site → Import from Git** → elige el repo →
Publish directory: `public` → Deploy. Cada `git push` re-despliega solo.

---

## PASO 3 — Tu dominio de Spaceship (opcional, cuando quieras)

1. Compra el dominio en https://www.spaceship.com
2. En Netlify: **Domain settings → Add a domain** → escribe tu dominio.
3. Netlify te muestra unos **nameservers** (ej. `dns1.p0X.nsone.net`...).
4. En Spaceship: panel del dominio → **Nameservers** → cambia a *Custom* y
   pega los de Netlify. Guarda.
5. Espera de minutos a unas horas. Netlify activa el **HTTPS gratis** solo.

No necesitas hosting aparte: Netlify ES el hosting; Spaceship solo es el nombre.

---

## Moderar reportes
Para borrar o corregir algo: Supabase → **Table editor** → tabla `reportes`.
Desde la web nadie puede editar ni borrar (solo crear y leer).

## Personalizar
- Teléfonos: edita el objeto `TEL` en `index.html`.
- Tipos de reporte / colores: edita el objeto `TYPES` en `index.html`.
- Vista inicial del mapa: busca `setView([10.48,-66.90],11)` en `index.html`.
