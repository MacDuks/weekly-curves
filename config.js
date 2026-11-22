// Подключение к Supabase для всех устройств сразу.
// Заполни две строки один раз — и на телефоне, и на новом компьютере
// шаг «Подключить базу» пропадёт, останется только вход по почте.
//
// url — Project URL,     Supabase → Project Settings → API Keys
// key — publishable key, оттуда же, начинается с sb_publishable_
//
// Этот ключ публичный по замыслу Supabase: доступ к строкам закрывает RLS,
// она привязывает каждую строку к твоему логину. Secret key сюда класть нельзя.
//
// Пока строки пустые, приложение спрашивает их на первом экране и запоминает
// в том браузере, где ввёл.

window.APP_CONFIG = {
  url: "https://gxnxevwwnuenvsfrvpqn.supabase.co",
  key: "sb_publishable_bHNcrmWXem3U-wdoLKpJOQ_SNwiV4cb"
};
