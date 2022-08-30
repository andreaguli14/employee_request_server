import { createApp } from 'vue'
import App from './App.vue'
import BootstrapVue3 from 'bootstrap-vue-3'
import router from './router'
import Datepicker from 'vuejs3-datepicker';

const app = createApp(App)
app.use(BootstrapVue3)
app.use(router)
app.use(Datepicker)
app.mount('#app')
