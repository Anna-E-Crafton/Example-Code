/*  script.js
    General JS for web design final project 
    Anna Crafton
    12/12/2024 */


//setFooterTexts()
//Function to dynamicly add footer text with current year
function setFooterText(){

    currentYear = new Date().getFullYear();
    document.getElementById("footerText").innerHTML="&copy;" + currentYear + ", Anna Crafton. All Rights Reserved.";
}

setFooterText();

//checkAll()
//Function to return true if email, phone, and name inputs are filled
//returns false if any inputs are not filled
function checkAllInputs(){

    nameInput = document.getElementById("name").value;
    emailInput = document.getElementById("email").value;
    phoneInput = document.getElementById("phone").value;

    if (nameInput == "" || emailInput == "" || phoneInput == "") {

        alert("Email, Name, and Phone must be filled out before submiting!");
        return false;
    }

    //returns true if all inputs are filled
    return true;
    
}



//createTable()
//Function to check if table exists and make one if needed.
function createTable() {

    //If table does not exist, then create one
    if (!(document.getElementById("inputTable"))){

        
        //adds a header above the table
        var tableHeader = document.createElement('h2');
        var headerText = document.createTextNode("Registration Information");
        tableHeader.appendChild(headerText);
        document.getElementById("tableDiv").appendChild(tableHeader);


        //Create the Table

        var table = document.createElement('table');
        table.id = "inputTable";

        var row = table.insertRow(0);

        //Creates a table with one row and three headings
        var headerOne = document.createTextNode("Name");
        var cell = row.insertCell(0);
        cell.appendChild(headerOne);

        var headerTwo = document.createTextNode("Email");
        var cell = row.insertCell(1);
        cell.appendChild(headerTwo);

        var headerThree = document.createTextNode("Phone");
        var cell = row.insertCell(2);
        cell.appendChild(headerThree);

        //adds the new table to tableDiv in registration.html
        document.getElementById("tableDiv").appendChild(table);

    }

}


//updateTable()
//function to check required inputs, then create and update a table when form is submited
//gets data from the input form in registration.html
function updateTable() {

    //if all fields are filled
    if (checkAllInputs()){

        //make a new table with headings (if none exists)
        createTable();

        var table = document.getElementById("inputTable");

        var name = document.getElementById("name").value; 
        var email = document.getElementById("email").value;
        var phone = document.getElementById("phone").value;

        var row = table.insertRow(-1);

        //Add name, email, and phone to row.
        var nameNode = document.createTextNode(name);
        var nameCell = row.insertCell(0);
        nameCell.appendChild(nameNode);

        var emailNode = document.createTextNode(email);
        var emailCell = row.insertCell(1);
        emailCell.appendChild(emailNode);

        var phoneNode = document.createTextNode(phone);
        var phoneCell = row.insertCell(2);
        phoneCell.appendChild(phoneNode);

        //then reset the input boxes
        clearForm();
    }

} 
    
//clearForm()
//Function to clear input form on submit
function clearForm() {

    document.getElementById("name").value = "";
    document.getElementById("email").value = "";
    document.getElementById("phone").value = "";

}
 



