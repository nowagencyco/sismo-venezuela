// ============================================================
//  CONFIGURACIÓN — fuentes de datos
// ============================================================

// --- TU base de datos (donde se GUARDA lo que publican en tu sitio) ---
window.SUPABASE_URL = "https://sczppmtxgcuufwubbgiz.supabase.co";
window.SUPABASE_ANON_KEY = "sb_publishable__0M9DZaey0vll1EM7YeiPA_xpmb-dYG";

// --- Base EXTERNA de solo lectura (datos de las fuentes oficiales) ---
// Con autorización del dueño. Tu sitio SOLO LEE de aquí, no escribe.
window.EXTERNAL_SOURCES = [
  {
    name: "Desaparecidos Terremoto VE",
    url: "https://enjvyowctvyuluhesojm.supabase.co",
    key: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVuanZ5b3djdHZ5dWx1aGVzb2ptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIzNjc2NTMsImV4cCI6MjA5Nzk0MzY1M30.Z_hbM_R2gRpTkvwIuAt7WWjPHXIll2Ctn5yVbefn1tE",
    table: "reportes"
  }
];

// --- GoHighLevel (CRM) — webhook donde se copia cada reporte como contacto ---
// Pega aquí la URL del Inbound Webhook de tu workflow de GHL.
// Déjalo vacío ("") si aún no lo tienes; el sitio funcionará igual.
// IMPORTANTE: el workflow de GHL solo debe "Create/Update Contact",
// sin acciones de SMS/llamada/email, para que no genere costos.
window.GHL_WEBHOOK_URL = "https://services.leadconnectorhq.com/hooks/zvg7dYiCLDm2RaYLUQva/webhook-trigger/bc8876c8-7c27-443d-97e5-5cf6ce8671f2";

// --- Cifra de PRESUNTOS FALLECIDOS (manual) ---
// Actualiza este número cuando EFE u otra fuente oficial lo informe.
// Pon null si prefieres que NO se muestre la tarjeta.
window.FALLECIDOS = {
  total: 1450,                 // ← cambia este número
  fuente: "EFE",               // ← fuente del dato
  actualizado: "27 jun 2026"   // ← fecha de actualización
};
