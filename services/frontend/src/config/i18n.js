import i18n from 'i18next'
import LanguageDetector from 'i18next-browser-languagedetector'
import XHR from 'i18next-xhr-backend'

i18n
  .use(XHR)
  .use(LanguageDetector)
  .init({
    fallbackLng: 'en',
    load: 'languageOnly',
    ns: ['global', 'home', 'errors'],
    defaultNS: 'global',
    interpolation: {
      escapeValue: false
    },
    react: {
      wait: true
    },
    default: ['en'],
    backend: {
      loadPath: '/locales/{{lng}}/{{ns}}.json'
    }
  })

export default i18n
