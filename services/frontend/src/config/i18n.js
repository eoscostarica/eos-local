import i18n from 'i18next'
import LanguageDetector from 'i18next-browser-languagedetector'
import language from '../language'

i18n.use(LanguageDetector).init({
  fallbackLng: 'en',
  ns: ['translations'],
  defaultNS: 'translations',
  interpolation: {
    escapeValue: false
  },
  react: {
    wait: true
  },
  default: ['en'],
  resources: {
    ...language
  }
})

export default i18n
