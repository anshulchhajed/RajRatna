$("#mobile").mask("9999999999");


function verify()
{
if(document.getElementById("custname").value==" ")
{
alert("Please Enter Customer Name");
custname.focus();
return false;
}
return true;
}