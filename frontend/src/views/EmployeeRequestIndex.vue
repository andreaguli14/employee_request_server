<template>
    <section class="ftco-section">
		<div class="container">
			<button class="button-66" @click="$router.push('create-employee-resquest')" role="button">Add new User</button><br>
			<div class="princtitle" ><h1 class="formtitle">Employee Request Index</h1></div>
						<div class="table-wrap">
							<table class="table">
								<thead class="thead-primary">
									<tr>
										<th>Start Date</th>
										<th>Name / Surname</th>
										<th>Job Title</th>
										<th>Reports to:</th>
										<th>Is Complete:</th>
									</tr>
								</thead>
								<tbody v-for="employee in employees" :key="employee.id" >
									<tr>
										<th scope="row">{{employee.startDate}}</th>
										<td>{{employee.name}} {{employee.surname}}</td>
										<td>{{employee.jobTitle}}</td>
										<td>{{employee.reportsTo}}</td>
										<td>
											<button class="button-40" role="button" @click="confirmecomplete(employee)">
											<span v-if="employee.isComplete">Complete</span> 
											<span v-if="!employee.isComplete">Not complete</span>
											</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
		</div>
	</section>
	
</template>

<script>
import axios from "axios";
const localURL = "http://localhost:3000/EmployeeRequests/"
export default {
  name:'EmployeeRequestIndex',
  data() {
    return {
      	employees:null,
    }
  },
  methods: {
	async confirmecomplete(employee) {
      try {
        const res = await axios.patch(localURL+ employee.id, { isComplete: !employee.isComplete});
		this.$router.go(this.$router.currentRoute)
      } catch (e) {
	
        console.error(e);
      }
    }
  },
  mounted() {
    fetch(localURL)
    .then(res => res.json())
    .then(data => this.employees = data)
    .catch(err => console.log("ERROR"))
  }
}
</script>

<style>
.formtitle{
	margin:auto;
	margin-bottom: 20px;
	}

@import "/src/css/style.css";
</style>

