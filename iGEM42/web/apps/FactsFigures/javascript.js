<script>

var Filters = function() {this.initialize.apply(this, arguments)}
Filters.prototype = {
	initialize: function(filter) {
		this.FilterNodes = document.getElementById("AllFilters").childNodes;
		this.UlNodes = document.getElementById("FilterUl").childNodes;
	},
	Show: function(element, link) {
		for(var i = 0; i < this.FilterNodes.length; i++) {
			if(this.FilterNodes[i].tagName != undefined) this.FilterNodes[i].style.display = "none"
		}
		for(var i = 0; i < this.UlNodes.length; i++) {
			if (this.UlNodes[i].tagName == "LI") this.UlNodes[i].style.borderBottom = "1pt solid #BBBBBB"
		}
		document.getElementById(element).style.display = "block";
		document.getElementById(link).parentNode.style.borderBottom = "1pt solid white";
	},
	Drop: function(element) {
		var children = document.getElementById(element).parentNode.childNodes;
		for(var i=0; i<children.length; i++) {
			if(children[i].tagName == "A") {var node = i; break;}
		}
		for(var i=(node+1); i<children.length; i++) {
			if (children[i].tagName != undefined) {
				if (children[i].style.display != "none") children[i].style.display = "none";
				else children[i].style.display = "block";
			}
		}
	}
}
var Filter = new Filters(document.getElementById("Filters"));
var toggle = document.getElementById("Filters").getElementsByTagName("UL")[0].getElementsByTagName("A")[0];
toggle.onclick.apply(toggle);

var TeamNames = [ "Aberdeen Scotland", "Alberta", "Alberta-North-RBI", "Alberta NINT", "Amsterdam", "Arizona State", "ArtScienceBangalore", "Austin Texas", "Baltimore", "Baltimore US", "Bangalore", "Bard-Annandale", "Baskent-Meds", "BAU-Indonesia", "Bay Area RSI", "BCCS-Bristol", "Beijing Normal", "Berkeley", "Berkeley LBL", "Berkeley Software", "Berkeley UC", "Berkeley Wetlab", "Bielefeld-Germany", "Bilkent UNAM Turkey", "BIOTEC Dresden", "Bologna", "Bonn", "Bordeaux", "Boston University", "BostonU", "British Columbia", "Brown", "Brown-Stanford", "BrownTwo", "BU Wellesley Software", "Buenos Aires", "BYU Provo", "BYUProvo", "Calgary", "Calgary Ethics", "Calgary Software", "Calgary Wetware", "Caltech", "Cambridge", "Cape Peninsula", "Carnegie Mellon", "CBNU-Korea", "CD-SCU-CHINA", "Chalmers-Gothenburg", "Chiba", "chicago", "Ciencias-UNAM", "CINVESTAV-IPN-UNAM MX", "CityColSanFrancisco", "Clemson", "CMU-Shenyang", "Colombia", "Colombia Israel", "Colorado State", "Columbia-Cooper", "Columbia-Cooper-NYC", "CongoDRC-Bel Campus", "Copenhagen", "Cornell", "Costa Rica-TEC-UNA", "CPU", "CPU-NanJing", "CSHL", "CTGU-Yichang", "CU-Boulder", "Davidson-Missouri Western", "Davidson-MissouriW", "Davidson Missouri W", "Debrecen-Hungary", "Debrecen Hungary", "DTU-Denmark", "DTU-Denmark-2", "DTU Denmark", "Duke", "Dundee", "ECUST-Shanghai", "Edinburgh", "Ehime-Japan", "ENSPS-Strasbourg", "EPF-Lausanne", "EPF Lausanne", "ESBS-Strasbourg", "ETH Zurich", "ETHZ", "ETHZ Basel", "Evry", "Exeter", "Fatih-Medical", "Fatih Turkey", "Frankfurt", "Freiburg", "Freiburg bioware", "Freiburg Bioware", "Freiburg software", "Freiburg Software", "Fudan-Shanghai", "Fudan D", "Fudan Lux", "Gaston Day School", "Georgia State", "Georgia Tech", "GeorgiaState", "GeorgiaTech", "Glasgow", "Goettingen", "Gothenburg-Sweden", "Grenoble", "Grinnell", "Groningen", "Guelph", "Harvard", "Harvey Mudd", "Hawaii", "Heidelberg", "HIT-Harbin", "HKU-HKBU", "HKU-Hong Kong", "HKU HongKong", "HKUST", "HKUST-Hong Kong", "HKUSTers", "HokkaidoU Japan", "Hong Kong-CUHK", "HSU", "HU-Micro", "Hunter-NYC", "HUST-China", "IBB-Pune", "IBB Pune", "IGIB-Delhi", "iHKU", "IIT Bombay India", "IIT Delhi 1", "IIT Madras", "IITBombay", "Illinois", "Illinois-Tools", "Imperial", "Imperial College", "Imperial College London", "Indiana", "INSA-Lyon", "IPN-UNAM-Mexico", "IPOC1-Colombia", "IPOC2-Colombia", "Istanbul", "ITESM Mexico", "IvyTech-South Bend", "Johns Hopkins", "Johns Hopkins-BAG", "Johns Hopkins-Software", "Johns Hopkins-Wetware", "JUIT-India", "KABK ArtScience", "KAIST-Korea", "KAIST Korea", "KAIT Japan", "KIT-Kyoto", "Korea U Seoul", "KU Seoul", "KULeuven", "Kyoto", "LCG-UNAM-Mexico", "LED", "Leicester", "Lethbridge", "Lethbridge CCS", "Ljubljana", "Lleida-Spain", "LMU-Munich", "Lyon-INSA", "Lyon-INSA-ENS", "Macquarie Australia", "Manitoba", "Marburg SYNMIKRO", "McGill", "McMaster-Ontario", "Melbourne", "METU", "METU-Ankara", "METU-BIN Ankara", "METU-Gene", "METU Turkey", "METU Turkey SoftLab", "METU Turkey Software", "Mexico", "Mexico-UNAM-CINVESTAV", "Mexico-UNAM-IPN", "Michigan", "Minnesota", "Mississippi State", "Missouri Miners", "MIT", "Monash Australia", "Montreal", "MoWestern Davidson", "Nairobi", "Nanjing", "Nanjing-China", "Nanjing China Bio", "Naples", "NCTU Formosa", "Nevada", "Newcastle", "Newcastle University", "Northeastern", "Northwestern", "NOUVEAUPARADIGMESCIENTIFIQUE", "NRP-UEA-Norwich", "NTHU BioEE", "NTNU Trondheim", "NTU-Singapore", "NTU-Taida", "NYC Hunter", "NYC Hunter Software", "NYC Software", "NYC Wetware", "NYMU-Taipei", "NYU", "NYU Gallatin", "Osaka", "OUC-China", "Panama", "Panama INDICASAT", "Paris", "Paris-Saclay", "Paris Bettencourt", "Paris Liliane Bettencourt", "Peking", "Peking R", "Peking S", "Peking University", "Penn", "Penn State", "PennState", "Peru", "PKU Beijing", "Polytech", "Potsdam Bioware", "Prairie View", "Princeton", "Purdue", "Queens", "Queens-Canada", "Queens Canada", "Rajasthan", "Reed", "Rensselaer", "RHIT", "Rice", "Rice University", "RMIT Australia", "Rutgers", "Saint Petersburg", "Saitama", "SDU-Denmark", "SEU A", "SEU O China", "Sevilla", "Sheffield", "Shenzhen", "SJTU-BioX-Shanghai", "SJTU-Oncology-Shanghai", "Slovenia", "Sofia BG", "SogangU-Korea", "Southampton", "Southern Utah", "St Andrews", "Stanford", "Stanford-Brown", "Stockholm", "Strathclyde Glasgow", "SupBiotech-Paris", "SUSTC-Shenzhen-A", "SUSTC-Shenzhen-B", "Sweden", "SYSU-China", "SYSU-Software", "Taipei", "Tec-Monterrey", "Tec-Monterrey Bio", "Tec-Monterrey EKAM", "Technion", "The Citadel-Charleston", "Tianjin", "TMU-Tokyo", "Todai-Tokyo", "Tokyo-Nokogen", "Tokyo-NoKoGen", "Tokyo Metropolitan", "Tokyo Tech", "Toronto", "Toronto Bluegenes", "TorontoMaRSDiscovery", "Trieste", "Tsinghua", "Tsinghua-A", "Tsinghua-D", "TU-Delft", "TU-Eindhoven", "TU Darmstadt", "TU Delft", "TU Munchen", "TU Munich", "TUDelft", "Tuebingen", "Turkey", "TzuChiU Formosa", "UAB-Barcelona", "UANL Mty-Mexico", "UC-Merced", "UC Berkeley", "UC Berkeley Tools", "UC Chile", "UC Davis", "UChicago", "UCL London", "UConn", "UCSF", "UEA-JIC Norwich", "UGA-Georgia", "UIUC-Illinois", "UIUC-Illinois-Software", "ULatinaPTY", "ULB-Brussels", "UMD", "UMiami", "UNAM-Genomics Mexico", "UNAM-ITESM Mexico City", "UNAM Genomics Mexico", "UNC Chapel Hill", "UNICAMP-Brazil", "UNICAMP-EMSE Brazil", "UNIPV-Pavia", "UNIST Korea", "UNITN-Trento", "UNITS Trieste", "University College London", "University of Alberta", "University of Chicago", "University of Lethbridge", "University of Ottawa", "University of Sheffield", "University of Washington", "uOttawa", "uOttawa CA", "UPIBI-Mexico", "UPO-Sevilla", "Uppsala-Sweden", "Uppsala University", "UQ-Australia", "UQ Australia", "USC", "USP-UNESP-Brazil", "UST-Beijing", "USTC", "USTC-China", "USTC-Software", "USTC Software", "UT-Tokyo", "UT-Tokyo-Software", "UT Dallas", "Utah State", "UTBC-RDCongo", "UTDallas", "UTK-Knoxville", "UTP-Panama", "UTP-Poland", "UTP-Software", "Valencia", "Valencia Biocampus", "VCU", "Victoria Australia", "VictoriaBC", "Virginia", "Virginia Commonwealth", "Virginia Tech", "Virginia United", "VIT Vellore", "VT-ENSIMAG Biosecurity", "Wageningen UR", "Warsaw", "Waseda-Japan", "Wash U", "Washington", "Washington-Software", "WashU", "Waterloo", "WEGO Taipei", "Weimar-Heidelberg Arts", "Wellesley HCI", "West Point", "WesternU-Research Ontario", "Westminster", "WHU-China", "Wisconsin", "Wisconsin-Madison", "WITS-CSIR SA", "WITS-South Africa", "WLC-Milwaukee", "XMU-China", "Yale", "Yeshiva NYC", "ZJU-China" ];

var NameInput = document.getElementById('FILname');
NameInput.oninput = function() {NameCompletion();}
var NameCompletion = function() {
	var Name = NameInput.value;
	var Names = new Array();
	while (Name.indexOf(',') !== -1) {
		Names.push(Name.substring(0, Name.indexOf(',')-1));
		if (Name[Name.indexOf(',')+1] == ' ') {Name = Name.substring(Name.indexOf(',')+2, Name.length);}
		else if (Name[Name.indexOf(',')+1] !== ' ') {Name = Name.substring(Name.indexOf(',')+1, Name.length);}
	}
	Names.push(Name);
	for (var i=0; i < Names.length; i++) {
		if (TeamNames.indexOf(Names[i]) == -1) {
			NameInput.style.color = "red";
		} else {
			NameInput.style.color = "black";
		}
	}
}
</script>