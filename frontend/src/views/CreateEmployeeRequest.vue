<template>
    <section class="ftco-section">
		<div class="container">
			<button class="button-66" @click="$router.push('/')" role="button">Employee Request Index</button><br><br><br>
			<div class="row ">
				<div class="col-md-12" >
                    <form class="createuserform"  @submit.prevent="submituser()">
                        <h1 class="formtitle">Create Employee Request</h1>
                            <div class="row">
                                <div class="col-md">
                                    <label class="labelform">Name</label>
                                    <input  class="inputform" name="firstname" id="name" type="text" required v-model="name">
                                </div>
                                <div class="col-md">
                                    <label class="labelform">Surname</label>
                                    <input class="inputform" name="lastname" id="surname" type="text" required v-model="surname">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md">
                                    <label class="labelform">Username</label>
                                    <input class="inputform" name="firstname" id="name" type="text" required v-model="username">
                                </div>
                                <div class="col-md">
                                    <label class="labelform">Domain:</label>
                                    <select class="selectform" name="domain" id="domain" v-model="domain">
                                        <option value="@inspectra.local" selected>inspectra.local</option>
                                        <option value="@inspectra.eu" >inspectra.eu</option>
                                        <option value="@prettyneat.io">prettyneat.io</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md">
                                    <label class="labelform">Job Title</label>
                                    <input class="inputform" id="jobTitle" type="text" required v-model="jobTitle">
                                </div>
                                <div class="col-md">
                                    <label class="labelform">Department</label>
                                    <input class="inputform" id="department" type="text" required v-model="department">
                                </div>
                            </div>
                              <div class="row">
                                    <div class="col-md">
                                        <label class="labelform">Start Date</label><br>
                                            <datepicker id="startDate" required  v-model="startDate"></datepicker>
                                    </div>
                                    <div class="col-md">
                                        <label class="labelform">End Date</label><br>
                                        <datepicker id="startDate" required v-model="endDate"></datepicker>
                                    </div>
                                </div>
                             <label class="labelform">Report to:</label>
                            <input class="inputform" type="reportTo" required v-model="reportsTo">
                            <label class="labelform">Email:</label>
                            <input class="inputform" type="email" required v-model="email">
                            <label  class="labelform">Password:</label>
                            <input class="inputform" type="password" required v-model="tempPassword">
                            <label class="labelform">Additional Notes:</label>
                            <textarea name="additionalNotes" class="form-control" id="exampleFormControlTextarea1" rows="3" v-model="additionalNotes"></textarea>
                            <div>
                                <div class="row my-sm-2">
                                <div class="col-md labelform">
                                    <label  class="form-switch ">
                                    <span class="required">Laptop Required:</span>>
                                    <input class="f" type="checkbox" v-model="laptopRequired">
                                    <i></i>
                                </label>
                                </div>
                                <div class="col-md labelform">
                                    <label class="form-switch ">
                                    <span class="required">Desktop Required:</span>>
                                    <input class="f" type="checkbox" v-model="desktopRequired">
                                   <i></i>
                                </label>
                                </div>
                                <div class="col-md labelform">
                                      <label class="form-switch">
                                    <span class="required">Phone Required:</span>>
                                    <input class="f" type="checkbox" v-model="phoneRequired">
                                    <i></i>
                                </label> 
                                </div>
                            </div>
                            </div>
                            <div class="row my-sm-3">
                                <label>User to copy:&nbsp;</label>
                                <select class="" name="user" id="user" v-model="userToCopy"> 
                                         <option v-for="userini in userList"  :key="userini" :value="userini" >{{userini}}</option>
                                </select>&nbsp;
                                <button type="button" @click="saveOutput(),groupOfUser=[], isOpen = true">Check Permissions</button>
                                <Modal :open="isOpen" @close="isOpen = !isOpen">
                                    <div class="text-center" v-if="loadGroup">
                                        <div class="spinner-border text-primary marginspinner" role="status">
                                            <span class="sr-only">Loading...</span>
                                        </div>
                                    </div>
                                    <div v-for="group in groupOfUser" :key="group.id"> 
                                        <input type="checkbox" :value="group" v-model="groupSelected">
                                        <label>{{group}}</label>
                                    </div>
                                </Modal>
                            </div>
                            <div class="submit">
                                <button>Add user</button>
                            </div>
                     </form>
                </div>
			</div>
		</div>
	</section>
</template>

<script>
import Datepicker from 'vuejs3-datepicker';
import moment from 'moment'
import axios from "axios";
import Modal from "./Modal.vue";
import { ref } from "vue";
const localURL = "http://localhost:3000/EmployeeRequests/"
export default {
    setup() {
        const isOpen = ref(false);

        return { isOpen };
     },
    name: "CreateEmployeeRequest",
    components: {
        Datepicker,
        Modal
    },
        data() {
        return {
            name:'',
            surname:'',
            username:'',
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
            domain:'@inspectra.local',
            tempPassword:'',
		    userToCopy:"",
            groupOfUser:["koala","suca","melo"],
		    groupSelected:[],
            output:"",
            user:"",
            userList:[],
            loadGroup:true
        
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
                    username:this.username,
                    jobTitle:this.jobTitle,
                    department:this.department,
                    email: this.email,
                    tempPassword:this.tempPassword,
                    reportsTo:this.reportsTo,
                    additionalNotes:this.additionalNotes,
                    laptopRequired:this.laptopRequired,
                    desktopRequired:this.desktopRequired,
                    phoneRequired:this.phoneRequired,
                    isComplete:this.isComplete,
                    startDate: this.convertDate(this.startDate),
                    endDate: this.convertDate(this.endDate),
                    selectedGroup:this.groupSelected,
                    domain:this.domain,
                    id:this.username
                
                    });
                  axios.get("https://localhost:5555/createuser/" + this.username)
                  this.$router.go(this.$router.currentRoute) 
                } 
            catch (e) {
                console.error(e);
             }
         },
        async saveOutput() {
            let response = await axios.get("https://localhost:5555/script/" + this.userToCopy)
            this.loadGroup = false
            this.output = response.data
            console.log(this.output)
            this.output = this.output.replace(/[\r]/gm, '')
            this.groupOfUser = this.output.split('\n')
            this.groupOfUser.pop()
        }
         
 },
async mounted(){
    let response = await axios.get("https://localhost:5555/user/getuser")
    this.user = response.data
    console.log(this.user)
    this.user = this.user.replace(/[\r]/gm, '')
    this.userList = this.user.split('\n')
    this.userList.pop()
 }
           
}

</script>

<style >
.marginspinner{
    margin: 25% auto;
}
.required{
    font-size: 13px;
    margin-top: 10px;
}

.formtitle{
    font-size: 50px;
    text-align: center;
    margin-bottom: 20px;
}

 .createuserform{
    max-width: 50rem;
    margin:30px auto;
    background:white;
    text-align:left;
    padding:40px;
    border-radius:10px;
 }

.labelform{
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

 .inputform, .selectform{
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
  font-size: 8px;
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