import { createRouter, createWebHistory } from 'vue-router'
import CreateEmployeeRequest from '../views/CreateEmployeeRequest'
import EmployeeRequestIndex from '../views/EmployeeRequestIndex'

const routes = [

  {
    path: '/',
    name: 'EmployeeRequestIndex',
    component: EmployeeRequestIndex
  },
  {
    path: '/create-employee-resquest',
    name: 'CreateEmployeeRequest',
    component: CreateEmployeeRequest
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
