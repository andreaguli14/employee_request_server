<template>
    <section class="ftco-section">
		<div class="container">
			<button class="button-66 " @click="$router.push('/')" role="button">Employee Request Index</button><br><br><br>
			<div class="row ">
				<div class="col-md-12" >
                    <form @submit.prevent="submituser()">
                        <h1 class="formtitle">Create Employee Request</h1>
                            <div class="row">
                                <div class="col-md">
                                    <label>Name</label>
                                    <input  name="firstname" id="name" type="text" required v-model="name">
                                </div>
                                <div class="col-md">
                                    <label>Surname</label>
                                    <input name="lastname" id="surname" type="text" required v-model="surname">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md">
                                    <label>Job Title</label>
                                    <input  id="jobTitle" type="text" required v-model="jobTitle">
                                </div>
                                <div class="col-md">
                                    <label>Department</label>
                                    <input id="department" type="text" required v-model="department">
                                </div>
                            </div>
                              <div class="row">
                                    <div class="col-md">
                                        <label>Start Date</label><br>
                                            <datepicker id="startDate" required  v-model="startDate"></datepicker>
                                    </div>
                                    <div class="col-md">
                                        <label>End Date</label><br>
                                        <datepicker id="startDate" required v-model="endDate"></datepicker>
                                    </div>
                                </div>
                             <label>Report to:</label>
                            <input type="reportTo" required v-model="reportsTo">
                            <label>Email:</label>
                            <input type="email" required v-model="email">
                            <label>Additional Notes:</label>
                            <textarea name="additionalNotes" class="form-control" id="exampleFormControlTextarea1" rows="3" v-model="additionalNotes"></textarea>
                            <div>
                                <div class="row ">
                                <div class="col-md">
                                    <label class="form-switch">
                                    <span class="required">Laptop Required:</span>>
                                    <input class="f" type="checkbox" v-model="laptopRequired">
                                    <i></i>
                                </label>
                                </div>
                                <div class="col-md">
                                    <label class="form-switch">
                                    <span class="required">Desktop Required:</span>>
                                    <input class="f" type="checkbox" v-model="desktopRequired">
                                   <i></i>
                                </label>
                                </div>
                                <div class="col-md">
                                      <label class="form-switch">
                                    <span class="required">Phone Required:</span>>
                                    <input class="f" type="checkbox" v-model="phoneRequired">
                                    <i></i>
                                </label> 
                                </div>
                            </div>
                            </div>

                            <button @click="saveOutput()">salva output</button>
                            <input type="text" required v-model="userToCopy">
                            <div v-for="group in groupOfUser" :key="group.id"> 
                            <input type="checkbox" :value="group" v-model="groupSelected">
                            <label>{{group}}</label>
                            </div>
                            
                            <div class="submit">
                                <button>Add user</button>
                                <p>{{groupSelected}}</p>
                            </div>
                     </form>
                </div>
			</div>
		</div>

        <!-- <div>
            <h1>Test</h1>
            <p>name:{{name}}</p>
            <p>surname:{{surname}}</p>
            <p>jobTitle:{{jobTitle}}</p>
            <p>department:{{department}}</p>
            <p>email:{{email}}</p>
            <p>startDate:{{convertDate(startDate)}}</p>
            <p>endDate:{{convertDate(endDate)}}</p>
            <p>reportTo:{{reportsTo}}</p>
            <p>additionalNotes:{{additionalNotes}}</p>
            <p>laptopRequired:{{laptopRequired}}</p>
            <p>desktopRequired:{{desktopRequired}}</p>
            <p>phoneRequired:{{phoneRequired}}</p>
            <p>isComplete:{{isComplete}}</p>
        </div> -->
	</section>
</template>

<script>
import Datepicker from 'vuejs3-datepicker';
import moment from 'moment'
import axios from "axios";
const localURL = "http://localhost:3000/EmployeeRequests/"
export default {
    name: "CreateEmployeeRequest",
    components: {
        Datepicker
    },
        data() {
        return {
            name:'',
            surname:'',
            jobTitle:'',
            department:'',
            email: '',
            startDate: {},
            endDate: {},
            reportsTo:'',
            laptopRequired:false,
            desktopRequired:false,
            phoneRequired:false,
            additionalNotes:'',
            isComplete:false,

            
		    userToCopy:"",
            groupOfUser:[],
		    groupSelected:[],
            output:""
        
        }
    },
    methods: {
        convertDate(importDate) {
            return  moment(importDate).format('DD/MM/YYYY')
         },
        async submituser() {
            try {
                 const res = await axios.post(localURL, { 
            
                    name:this.name,
                    surname:this.surname,
                    jobTitle:this.jobTitle,
                    department:this.department,
                    email: this.email,
                    reportsTo:this.reportsTo,
                    additionalNotes:this.additionalNotes,
                    laptopRequired:this.laptopRequired,
                    desktopRequired:this.desktopRequired,
                    phoneRequired:this.phoneRequired,
                    isComplete:this.isComplete,
                    startDate: this.convertDate(this.startDate),
                    endDate: this.convertDate(this.endDate),
                    selectedGroup:this.groupSelected
                
                    });
                  
                  this.$router.go(this.$router.currentRoute) 
                } 
            catch (e) {
                console.error(e);
             }
         },
         saveOutput() {
            axios
            .get("https://localhost:5555/script/" + this.userToCopy )
            .then(response => (this.output = response.data))
            .then(console.log(this.output))
            setTimeout(this.ricarica, 1500);
       

            
        },
        fetchoutput() {
            axios
                .get("https://localhost:5555/script/" + this.userToCopy)
                .then(response => (this.output = response.data))
                .then(console.log(this.output))
                .then(this.output = this.output.replace(/[\n]/gm, ''))
                .then(this.groupOfUser = this.output.split('\r'))
            },
        
 },
      mounted() {
          
              
            
  }
}

</script>

<style scoped>

.required{
    font-size: 13px;
    margin-top: 10px;
}

.formtitle{
    font-size: 50px;
    text-align: center;
    margin-bottom: 20px;
}

form{
    max-width: 50rem;
    margin:30px auto;
    background:white;
    text-align:left;
    padding:40px;
    border-radius:10px;
 }

label{
    color:#aaa;
    display: inline-block;
    margin:25px 0 15px;
    font-size:0.6em;
    text-transform:uppercase;
    letter-spacing:1px;
    font-weight:bold;
}
.additional-notes{
    display: inline-block
}

input, select{
  display:block;
  padding:10px 6px;
  width:100%;
  box-sizing:border-box;
  border:none;
  border-bottom:1px solid #ddd;
  color:#555;
}    

.submit button {
background: #0b6dff;
border: 0;
padding: 10px 20px;
margin-top: 20px;
color: white;
border-radius: 20px;
}

.submit {
text-align: center;
}  
.switch-label{
    display: inline-block;
}
.form-switch {
  display:inline-block;
  cursor: pointer;
  -webkit-tap-highlight-color: transparent;
}
.form-switch i {
  position: relative;
  display: inline-block;
  margin-right: .5rem;
  width: 46px;
  height: 26px;
  background-color: #e6e6e6;
  border-radius: 23px;
  vertical-align: text-bottom;
  transition: all 0.3s linear;
}
.form-switch i::before {
  content: "";
  position: absolute;
  left: 0;
  width: 42px;
  height: 22px;
  background-color: #fff;
  border-radius: 11px;
  transform: translate3d(2px, 2px, 0) scale3d(1, 1, 1);
  transition: all 0.25s linear;
}
.form-switch i::after {
  content: "";
  position: absolute;
  left: 0;
  width: 22px;
  height: 22px;
  background-color: #fff;
  border-radius: 11px;
  box-shadow: 0 2px 2px rgba(0, 0, 0, 0.24);
  transform: translate3d(2px, 2px, 0);
  transition: all 0.2s ease-in-out;
}
.form-switch:active i::after {
  width: 28px;
  transform: translate3d(2px, 2px, 0);
}
.form-switch:active input:checked + i::after { transform: translate3d(16px, 2px, 0); }
.form-switch input { display: none; }
.form-switch input:checked + i { background-color: #4BD763; }
.form-switch input:checked + i::before { transform: translate3d(18px, 2px, 0) scale3d(0, 0, 0); }
.form-switch input:checked + i::after { transform: translate3d(22px, 2px, 0); }


  

</style>