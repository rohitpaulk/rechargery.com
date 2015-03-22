var slider = function(){
    $('#RatesSlider').noUiSlider({
         range: [0,20000]
        ,handles: 1
        ,start: [2013]
        ,step: 1
        ,serialization: {
            resolution:1,
            to: [ $("#RatesOrderValue"), 'html' ]
           }
    });
    function UpdateValues(){
        var OrderValue=$("#RatesOrderValue").html();
        switch($('#storeinput').val()){
            case "3":
                if(OrderValue > 6666){
                    $('#RechargeValue').html("Rs " + "200");
                }
                else{
                    var Recharge = (OrderValue*0.03)-((OrderValue*0.03)%10);
                   $('#RechargeValue').html("Rs " + Recharge);
                }
                break;
            case "1":
                if(OrderValue > 6666){
                    $('#RechargeValue').html("Rs " + "200");
                }
                else{
                    var Recharge = (OrderValue*0.03)-((OrderValue*0.03)%10);
                    $('#RechargeValue').html("Rs " + Recharge);
                }
                break;
            case "2":
                if(OrderValue > 500 ){
                    $('#RechargeValue').html("Rs " + "50");
                }else{
                    $('#RechargeValue').html("Rs " + "0");
                }
                break;
        
        }
    }
    $('#RatesSlider').on('change',UpdateValues);    
    $('#storeinput').on("change",UpdateValues);
    
    
};

$(document).on('page:change',slider);
$(document).ready(slider);