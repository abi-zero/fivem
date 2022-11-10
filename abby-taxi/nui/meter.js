$(function() {

    var meterVisible = true;
    var currencyPrefix = '$';
    var rateSuffix = '/km';
    var rateType = 'distance';
    var rateAmount = null;
    var currentFare = 0;
    var oldFare = '0000.00';
  
      window.addEventListener("message", function(event) {
      switch(event.data.type) {
        case 'update_fare':
          updateFare(event.data.fare);
          break;
        case 'update_rate':
          setRate(event.data.rate);
          break;
        case 'show_meter':
          showMeter();
          break;
        case 'hide_meter':
          hideMeter();
          break;
        default:
      }
    });
  
    function showMeter() {
      $('#meter').show();
    }
  
    function hideMeter() {
      $('#meter').hide();
    }
  
    async function setRate(rate) {
      rate = String(rate);
      for (let i=1; i<=Math.min(rate.length,3); i++) {
        if (rate[rate.length - i] == '.'){
          document.getElementById('rate'+-i).src = 'img/dot.png';
        } else {
          document.getElementById('rate'+-i).src = 'img/' + rate[rate.length - i] + ".png";
        }
      }
      for (let i=rate.length+1; i<=3; i++) {
          document.getElementById('rate'+-i).src = "img/0.png";
      }
    }
    async function updateFare(fare) {
      fare = fare.toFixed(2);
      fare = String(fare);
      fare = fare.padStart(7,'0');
      
      for (let i=1; i<=7; i++) {
        if (oldFare[7 - i] != '.') { // If it isn't in the dot position
          document.getElementById('amt'+-i).style.objectPosition = '0px -' + (32*parseInt(oldFare[7-i])) + 'px';
        }
      }
      for(let i=1; i<=7; i++){
        if (oldFare[7-i] != fare[7-i]) {
          oldNum = parseInt(oldFare[7-i]);
          newNum = parseInt(fare[7-i])
          if (newNum < oldNum) {
            newNum = newNum + 10;
          }
          totalAnims = newNum-oldNum;
          for(let j=oldNum+1; j<=newNum; j++) {
            document.getElementById('amt'+-i).classList.add('anim' + j%10);
            document.getElementById('amt'+-i).style.animationDuration = 200/totalAnims + 'ms';
            await new Promise(r => setTimeout(r, 200/totalAnims));
            document.getElementById('amt'+-i).classList.remove('anim' + j%10);
          }
        }
        document.getElementById('amt'+-i).style.objectPosition = '0px -' + (32*parseInt(fare[7-i])) + 'px';
      }
      oldFare = fare
  }
    function refreshMeterDisplay(){
      toggleMeterVisibility();
      updateRateType();
      updateCurrentFare();
    }
  
    function toggleMeterVisibility(){
      if(meterVisible){
        showMeter();
      } else {
        hideMeter();
      }
    }
  
    function updateCurrentFare(){
      if(rateType == 'flat'){
        string = currencyPrefix + (rateAmount || '--');
      }else{
        string = currencyPrefix + (currentFare || '0.00');
      }
  
      $('.meter-field.fare').text(string);
    }
  
    function updateRateType() {
      if(rateType == 'flat'){
        string = 'FLAT'
      }else{
        string = currencyPrefix + (rateAmount || '--') + rateSuffix
      }
  
      $('.meter-field.rate').text(string);
    }
  
  });
  