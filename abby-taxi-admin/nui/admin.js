window.onload = function(){$('.container').hide();};
window.addEventListener("message", function(event) {
    switch(event.data.type) {
        case 'show':
            $('.container').show();
            break;
        case 'hide':
            $('.container').hide();
            break;
        case 'update_list':
            break;
        case 'update_navbar':
            break;
        case 'update_information':
            break;
        case 'update_trips':
            trips = JSON.parse(event.data.trips);
            clearTrips()
            for (let i in trips) {
                addTrip(trips[i])
            }
            break;
        case 'update_totals':
            addTotals(JSON.parse(event.data.data));
            break;
        case 'update_employees':
            addEmployees(JSON.parse(event.data.data));
            break;
        case 'update_statistics':
            addStatistics(JSON.parse(event.data.statistics));
            break;
        default:
    }
});

function numberWithCommas(x) {
    return x.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, " ");
}

function addTrip(trip) {
    var date = new Date(trip["date"]);
    var day = ("0"+date.getDate().toString()).substr(-2)
    var month = ("0"+date.getMonth().toString()).substr(-2);
    var year = date.getFullYear();
    var hour = ("0" + date.getHours().toString()).substr(-2);
    var minute = ("0" + date.getMinutes().toString()).substr(-2);
    var second = ("0" + date.getSeconds().toString()).substr(-2);

    const tripsTable = document.getElementById('trips');
    const newTrip = document.createElement("tr");

    const newDate = document.createElement("td");
    const newDateText = document.createTextNode(day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ':' + second);
    newDate.classList.add("date")
    newDate.appendChild(newDateText);
    newTrip.appendChild(newDate);

    const newName = document.createElement("td");
    const newNameText = document.createTextNode(trip["name"]);
    newName.classList.add("name");
    newName.appendChild(newNameText);
    newTrip.appendChild(newName);
    const newFare = document.createElement("td");
    const newFareText = document.createTextNode(numberWithCommas(trip["fare"]));
    newFare.classList.add("fare");
    newFare.appendChild(newFareText);
    newTrip.appendChild(newFare);

    const newPlayerCut = document.createElement("td");
    const newPlayerCutText = document.createTextNode(numberWithCommas(trip["playercut"]));
    newPlayerCut.classList.add("playercut");
    newPlayerCut.appendChild(newPlayerCutText);
    newTrip.appendChild(newPlayerCut);

    const newBusinessCut = document.createElement("td");
    const newBusinessCutText = document.createTextNode(numberWithCommas(trip["businesscut"]));
    newBusinessCut.classList.add("businesscut");
    newBusinessCut.appendChild(newBusinessCutText);
    newTrip.appendChild(newBusinessCut);
    
    tripsTable.appendChild(newTrip);
}
function clearTrips() {
    var elements = document.getElementById('trips').getElementsByTagName('tr');
    while (elements[1]) elements[1].parentNode.removeChild(elements[1]);
}

function addTotals(data) {
    //  data Format:
    //  [
    //      {"label":"Text that appears on the admin UI","total":Number that appears on the admin UI},
    //      ...
    //  ]
    const totalsTable = document.getElementById("totals");

    var elements = totalsTable.getElementsByTagName('tr');
    while (elements[1]) elements[1].parentNode.removeChild(elements[1]);

    
    for (let i in data) {
        total = data[i];
        row = document.createElement('tr');
        label = document.createElement('td');
        label.appendChild(document.createTextNode(total["label"]));
        value = document.createElement('td');
        value.classList.add('businesscut');
        value.appendChild(document.createTextNode(numberWithCommas(total["total"])));
        row.appendChild(label);
        row.appendChild(value);
        totalsTable.appendChild(row);
    }
}

function addEmployees(data) {
    const labels = {
        'lastHour':'Last Hour',
        'lastSixHours':'Last 6 Hours',
        'lastTwentyFourHours':'Last 24 Hours',
        'lastWeek':'Last 7 Days',
        'lastFortnight':'Last 14 Days',
        'lastMonth':'Last 30 Days',
    };
    const bestEmployeesTable = document.getElementById('best-employees');
    const worstEmployeesTable = document.getElementById('worst-employees');
    

    var elements = bestEmployeesTable.getElementsByTagName('tr');
    while (elements[1]) elements[1].parentNode.removeChild(elements[1]);

    var elements = worstEmployeesTable.getElementsByTagName('tr');
    while (elements[1]) elements[1].parentNode.removeChild(elements[1]);

    for (let i in labels) {
        row = document.createElement('tr');
        label = document.createElement('td');
        label.appendChild(document.createTextNode(labels[i]));
        row.appendChild(label);
        try {
            nameValue = document.createElement('td');
            nameValue.appendChild(document.createTextNode(data["best"][i][0]["name"]))
            totalValue = document.createElement('td');
            totalValue.appendChild(document.createTextNode(numberWithCommas(data["best"][i][0]["total"])))
            totalValue.classList.add('businesscut');
            row.appendChild(nameValue);
            row.appendChild(totalValue);
        } catch (error) {
            
        }
        bestEmployeesTable.appendChild(row);
    }

    for (let i in labels) {
        row = document.createElement('tr');
        label = document.createElement('td');
        label.appendChild(document.createTextNode(labels[i]));
        row.appendChild(label);
        try {
            nameValue = document.createElement('td');
            nameValue.appendChild(document.createTextNode(data["worst"][i][0]["name"]))
            totalValue = document.createElement('td');
            totalValue.appendChild(document.createTextNode(numberWithCommas(data["worst"][i][0]["total"])))
            totalValue.classList.add('businesscut');
            row.appendChild(nameValue);
            row.appendChild(totalValue);
        } catch (error) {
            
        }
        worstEmployeesTable.appendChild(row);
    }
}

function addStatistics(data) {
    const statisticsTable = document.getElementById('statistics');
    var elements = statisticsTable.getElementsByTagName('tr');
    while (elements[0]) elements[0].parentNode.removeChild(elements[0]);
    
    const labels = {
        0:'balance',
        1:'employees',
        'balance':'Company Balance $',
        'employees':'Number of Employees',
    }
    for (i=0; i<=1; i++) {
        row = document.createElement('tr');
        label = document.createElement('td');
        label.appendChild(document.createTextNode(labels[labels[i]]));
        row.appendChild(label)
        try {
            value = document.createElement('td');
            value.appendChild(document.createTextNode(numberWithCommas(data[i][0][labels[i]])));
            value.classList.add('number');
            row.appendChild(value);
        } catch (error) {
            
        }
        statisticsTable.appendChild(row);
    }
}