using Printf


include("rnn.jl")
# TODO: Batches, L2-reg,

X_train = loadX("data/mixed/lang/examples_train_1.txt")
y_train_ = loady("data/mixed/lang/labels_train_1.txt")
y_train = unrolly(y_train_)
X_test = loadX("data/mixed/lang/examples_test_1.txt")
k_test = size.(X_test,1)
X_test .= hcat.(X_test, ones.(TYPE, k_test))
k_train = size.(X_train, 1)
X_train .= hcat.(X_train, ones.(TYPE, k_train))
# @show size(X_test[1])
y_test_ = loady("data/mixed/lang/labels_test_1.txt")
y_test = unrolly(y_test_)
(n,c) = size(y_train)
t = size(y_test_, 1)

include("rnn.jl")

# sgd


# 98% test acc

nstate = 10
# Waa = randn(nstate, nstate)
# Waa = [-0.5892247418213822 -0.33780217872961366 0.26835257405820423 -1.5925884654242441 -0.5614736389062152; 0.6884119487736567 0.4749421193062428 -0.12853108111603806 1.2540930952974176 0.16766876463202193; -1.359469784772875 -1.4657480448006903 0.2594764354840852 -2.425361060390009 -1.2633284106833422; -0.5455703591736855 -0.007884238349909447 0.48045108031049644 0.467707422188827 0.0625601907718198; 0.8598485464935731 -1.1384108928278223 -1.4699837705648435 -0.6178532437409058 -0.6073700395832335]
# Wax = randn(nstate, (96 + 1))
# Wax = [0.8097019662929071 -0.337529641734784 0.8921194997008922 3.097861600325416 2.3998393280547665 0.4117428663252551 0.2819989221482649 -0.1655986165636043 1.4029739666071086 1.0420425456938676 1.5880810165096293 0.91755788276846 0.8768804742756356 1.7746362521867123 2.0494870111862005 2.4234444449821195 -0.023308824247125534 1.028437321202625 -0.3377773626340879 1.976506984796408 1.6127138918952648 1.1540839396296463 -0.5801515821706661 1.5438211165520455 0.43944835201035276 0.7720037899901943 -0.9796119016136763 1.2580034453166096 -0.37228123584548983 1.3767632422771447 0.48826389881266863 0.8894418047640759 1.6917579215022347 0.047659810442544984 -0.6132832483203076 -0.2511358618145107 0.19742954883772035 -1.3427246615744617 0.40277067418713725 1.94246474900779 1.2664020438292638 1.3998230984380353 0.5696973117084599 -0.8149651899952354 -0.8566688651795625 0.3994101674835742 0.5065232647769823 0.14831465508823055 -0.6866995645231969 0.8516235084753144 -1.4001111097516954 1.044855951782888 0.1668465013048388 -1.018350018280621 -0.5941658450132036 0.35669976547971277 1.2957481800393171 0.17755667495446426 -0.9503829549230233 0.02159793017022473 0.32179819989530806 1.1900402800885004 1.9875067581455135 0.9778733741020165 0.16154428809819482 -1.3449851504121886 1.318018554287314 1.9365412892124512 0.4324328220138824 2.066041286248229 2.7330750620461073 0.3089571568316329 1.6203792992145736 0.7179388227804021 -0.7789752948462233 0.4197594192134431 -0.5991789608789201 -1.1568173051028643 0.6423214166485319 -0.09009877477830362 3.0701138660759817 1.5592287862400431 -0.2597770514971757 0.4197316605676625 1.3235996306442754 1.2491813471685804 2.8016137508129964 -0.6471521943532342 0.630745538787412 -0.24521866517181828 1.141021803099892 -0.14494733980852842 1.4236640290064504 -0.44957581219754256 -0.9127016728351794 0.746819649578144 -1.8103790529731711; -1.1136497005825696 -0.05057582281514859 -0.7221247998392144 0.8887078568905562 0.6231394390989775 -0.5661092531705032 1.54727333775754 0.8152011131255583 -0.8651366784955745 -0.11173394589153404 0.570287640974622 0.845895516962009 -1.7653810730436652 0.7590492373582722 0.0984446020822049 1.764341253481821 0.37963552995930494 -1.3830300938491151 0.3225241569737639 -0.002913396785044804 0.8971728425013235 0.5694959396176567 -0.7767163216503152 -0.3112777148940783 0.8581938480989693 0.7377187117465074 0.5266314266753345 -0.9077659853643834 0.012689465107231863 0.30408826447413206 0.6114521740687142 1.043640702565513 0.5954822607007695 -0.5926226759731148 -0.6980272495011857 -0.5603306820619973 -0.2610640862248147 -0.10348366365767261 1.054374142062118 -0.3990549514072116 0.6283171317198151 0.42013424847737246 1.1175213721208077 0.21811685329302796 0.8544240085495289 -0.6203341590902138 0.2533650976046068 1.3908974329796802 -0.7689994361899213 0.4735514630790162 0.0065707327737628855 1.0473335763588658 -0.47832816770475306 1.4290179347790855 -0.06793310658456556 0.5562352378898328 1.0416507173523952 -1.539812677945213 0.28804425530495303 0.4338433008163465 -0.44834419859077046 -1.3184212307206467 -0.3389060401192059 -0.19548523509139973 0.24291777222469313 -0.13235980234306133 1.3594568301190668 -0.3237568674881579 0.24242056920715377 -0.550758565360081 0.4272313013281601 0.6831090952606842 2.885235487301174 -1.508353765988572 -0.9919301556132931 1.1457160046761452 -1.006102374050729 1.7327563943685618 0.47209737781567906 -1.0114212268391947 -1.3806034081266938 0.16456580802739754 0.706885483029325 0.28634970724287934 -0.18424672695683983 -1.168456163239352 0.15647384440090786 -3.5510863956114096 -0.609412222397034 -0.48032968927977515 -0.7458631914731431 1.186399059566276 -0.2515746876999022 0.15634071149833342 0.2614177953842783 -0.08238696997175157 0.1573664431539981; -0.11771817509487345 -0.3249560093164865 1.250840264583533 -0.1928285067066123 1.0494936857433304 -1.8043624316723972 -0.4398101286147077 -0.4777245745736291 -1.134000325149736 -1.05577475737732 -1.467545270996038 -1.1857702557896364 1.0875627817823 -0.7051019012082228 0.5773320580841673 0.3400114511764869 -1.348925484878429 -0.5630135899230818 -1.1583857186118975 -1.3848670813034496 -1.0171456744797904 -1.4587819045663752 -0.648972568639027 1.2333298167717017 -0.23291320242708258 -0.5020692952679375 -0.3406036316119163 -0.6480620013436648 -0.06634088506957603 0.14472908134403156 -0.9320459464262371 1.0309488024855766 0.589260666654776 1.135926917345646 1.1002484125737322 -1.6298512479357607 -0.7879353321513468 1.0786036042286553 0.8359688011878316 1.3361992359455148 1.339723580264173 -0.286059934598887 1.7960964922920581 0.3204692469828 -0.13139725112310138 0.6746766747515415 0.16071676434846907 -0.37400312243862366 -0.47432906015256554 -1.0414109402556257 -1.0570122970898987 0.531623302228348 0.8006118109560058 -0.4209717749491535 0.6031640942195658 -0.09261512690702475 1.4319823728429077 -0.3035435775539579 -0.1875903333948005 0.5038441711448042 -0.8257136692002017 -1.5899647755095705 1.6888786568275793 -1.3878457593194682 -0.9046102005282831 -0.9830987925092497 -0.6641588227293854 -1.3197165308094183 -1.5831095249419205 2.7823502979974615 1.3601486386447497 -1.3299234477039108 -1.2238912535846338 -0.45461460633028644 2.236666512654838 0.8115839401984658 0.4376765102550678 -0.1969778613055033 -0.5820903273070411 -0.4107078708589006 0.24308457483883214 0.13520792185469335 -1.7045482673749528 -0.8775233260055374 -0.12260775651947267 0.7678830315531519 -0.34451778579025905 -0.7593100610272684 -0.2830547430807545 -0.0013106875718827838 0.557413631540765 -0.10045626237591587 -0.5270253691077528 -0.27909505306706966 -0.07611891851935543 0.6464970634292345 -0.7760825367585004; 0.2185462053394324 -1.5080035766003081 0.6575391856022069 0.13100455282097548 0.8765427975880641 -1.0358023005895485 0.10743938490136413 -0.5889419951292961 -1.7923881863306865 1.2046663573014584 0.5266800585912935 0.11979274639911237 0.13921768072327492 -1.2402403633524488 1.3536282869279301 -1.180387186155303 0.652251691212035 -0.8724419553685879 1.3691542606859104 -0.26166393244566666 0.42293558823567057 0.6252260473718548 -0.10813440226539851 -1.3671630094868739 -1.5122120860161685 0.3383339162547946 -0.07020575526089474 0.5913030005349996 1.5048336326877931 -1.242873979665066 -0.18359734923708856 -1.3617406571877397 -1.6914662894506651 0.28105417796321985 -0.019528682789876847 -1.2901027744405178 1.0799263038075615 1.427082461643842 0.4027977965345809 0.005703851858937851 -0.31953338090704875 -0.16883236582238423 0.385403956775503 -1.976616318316262 0.49627577761665764 -1.4054607354046265 -0.1913262573452012 -2.0376576626861205 0.16333402887385204 0.30449169978471136 0.5179088443780043 -0.3726892638441953 -0.3723643378366709 -1.1669234246197118 0.5294076231392176 0.5558472909057256 0.9536834629896564 0.06893610042646484 0.7059947911096788 0.9123165851527182 0.8378579408428802 -1.8246663529747729 1.7148604961863427 -0.4711555333712548 0.5551803821360074 0.9582125824514016 0.9917328662784799 1.1741828851814404 -1.0189313125121167 -0.659252561822821 -0.4887936138550997 0.07269641696312354 -1.4781253053587784 0.4852380810733702 0.21923075794754746 0.029635691187667377 0.1251201165829041 0.5006948398432803 1.0935930700545804 -1.098520762901753 0.5458458748637575 -1.1443145933091465 2.108417550631474 0.5756766567886383 -0.22017462332802304 -0.49314394660312144 0.902124639025257 0.33082946186768314 0.7914678816834985 0.7702736844860919 -1.9603646028250796 1.645269711516841 0.2906506327603928 0.5716338112727047 0.2391936366948951 -0.2832699970590835 -0.33132194531176207; 0.6094151894451045 0.5649192601373056 0.4932260466935044 2.260471460673354 0.8056988027645475 -1.6448737491800933 -0.543495336110523 1.9492250437986944 -0.7238689836182943 0.1475273022477581 0.5509484419902426 0.044003410225377036 1.409571556417261 0.589237792360241 0.9712438605171192 0.2399375271488017 0.881852812745108 1.5594005725819862 -0.2561993833514504 0.5487738842909411 0.21260485397486859 1.39342132752941 -1.167764370457421 -0.8159873022817001 -0.035185932444687346 -0.8013395540189758 -0.5290255336929668 -1.5623028561908965 0.3098134941985418 -0.8673284495829314 0.578316075861472 2.328668846026402 0.6785877734070782 -1.9875458098125336 0.21620360750644055 0.15365123382426757 1.6766987466466323 -0.8346839492964728 -1.349840938147566 0.4745504072537261 -1.2786834577350927 3.14422992170663 -1.6023884098430747 -0.31366983998925463 1.1737658006032723 1.7032066843004203 -0.31253260567702784 0.43093168169850576 0.7545763095686617 -0.5570971797012236 0.7814203398506498 0.528903210922885 0.08945168101613427 0.3182003014840193 1.8335091857572958 0.9376309176108923 1.8302422357487462 0.06739719515161732 0.8727652745394665 2.0341619348881643 1.725789400617438 -0.2447116380160401 0.9037725683435105 0.9472045441669941 0.5021099980717838 0.6029659143490265 0.573302247951468 -0.11044023862224998 1.6024189348375664 0.7234566314989865 0.6400497382084003 -0.34073954576506965 1.5052788262305505 0.232772468972011 0.58243357523176 -0.1543622147432077 0.9950314390458267 0.3001131474068166 -1.200178220674973 -0.18264842188721478 -1.6992410146890229 -0.03846249537481047 -1.4409374989698993 -0.838895795175197 0.4249980192657293 -0.5515743228215564 1.1425474587095554 -1.647873380781342 -0.7729903146900565 1.8785007532531528 0.7607010957331237 1.4195235073122936 -0.44686189923052755 -0.027707981925406404 0.22844946247671336 0.6341619862112085 -0.8825502391964606]
# Wya = randn(c, nstate + 1)
# Wya = [-1.3103692937142342 -0.27245918099497024 1.0469921490913814 2.8726946986484934 1.6766407946350583 -0.4040910409622134; 0.8930883228105131 -1.4109173555326668 -2.2709838658272523 -0.551020295720099 -0.4498014344509144 1.1401777932523822]
# a0 = randn(nstate)
# a0 = [0.09500955238931222, 1.1051366060134007, 1.2681733548624794, 1.0885732359150107, -0.39822393517465365]
include("weights.jl")

BATCH_SIZE = 10
MAX_ITERATIONS = Int(round(100000/BATCH_SIZE))
# MAX_ITERATIONS = 0
STEP_SIZE = 7e-2

for i in 1:MAX_ITERATIONS
	f_sum = 0
	gWaa_sum = zeros(TYPE, size(Waa))
	gWax_sum = zeros(TYPE, size(Wax))
	gWya_sum = zeros(TYPE, size(Wya))
	ga0_sum = zeros(TYPE, size(a0))

	for batch in 1:BATCH_SIZE
		r = rand(1:n)
		(f, gWaa, gWax, gWya, ga0) = bptt(Waa, Wax, Wya, a0, X_train[r], y_train[r,:])
		f_sum += f
		gWaa_sum += gWaa
		gWax_sum += gWax
		gWya_sum += gWya
		ga0_sum += ga0
	end
	# r = rand(1:n)
	# (f, gWaa, gWax, gWya, ga0) = bptt(Waa, Wax, Wya, a0, X_train[r], y_train[r,:])
	global Waa = Waa - STEP_SIZE * gWaa_sum / BATCH_SIZE
	global Wax = Wax - STEP_SIZE * gWax_sum / BATCH_SIZE
	global Wya = Wya - STEP_SIZE * gWya_sum / BATCH_SIZE
	global a0 = a0 - STEP_SIZE * ga0_sum / BATCH_SIZE
	if i % Int(round(MAX_ITERATIONS/30)) == 0
		correct = 0
		test_err = 0
		yhat = predict(X_test, Waa, Wax, Wya, a0)
		for j in 1:t
			test_err += sum((yhat[j] - y_test[j,:]).^2)
			if findmax(yhat[j])[2] - 1 == y_test_[j]
				correct += 1
			end
		end
		test_err /= t
		test_acc = correct/t
		yhat = predict(X_train, Waa, Wax, Wya, a0)
		correct = 0
		train_err = 0
		for j in 1:n
			train_err += sum((yhat[j] - y_train[j,:]).^2)
			if findmax(yhat[j])[2] - 1 == y_train_[j]
				correct += 1
			end
		end
		train_err /= n
		train_acc = correct / n
		@printf "ITERATION: %d\tTRAIN ACC: %f\tTEST ACC: %f\tTRAIN ERR: %f\tTEST ERR: %f\n" i train_acc test_acc train_err test_err
	end
end

# @show Waa
# @show Wax
# @show Wya
# @show a0


correct = 0
test_err = 0
yhat = predict(X_test, Waa, Wax, Wya, a0)
for j in 1:t
	global test_err += sum((yhat[j] - y_test[j,:]).^2)
	if findmax(yhat[j])[2] - 1 == y_test_[j]
		global correct += 1
	end
end
test_err /= t
test_acc = correct/t
yhat = predict(X_train, Waa, Wax, Wya, a0)
correct = 0
train_err = 0
for j in 1:n
	global train_err += sum((yhat[j] - y_train[j,:]).^2)
	if findmax(yhat[j])[2] - 1 == y_train_[j]
		global correct += 1
	end
end
train_err /= n
train_acc = correct / n
@printf "TRAIN ACC: %f\tTEST ACC: %f\tTRAIN ERR: %f\tTEST ERR: %f\n" train_acc test_acc train_err test_err


function predictString(str)
	X_new = Vector{Array{TYPE, 2}}()
	push!(X_new, str2vec(str))
	X_new .= hcat.(X_new, ones.(TYPE, size.(X_new, 1)))
	yhat = predict(X_new, Waa, Wax, Wya, a0)
	if yhat[1][1] > yhat[1][2]
		print("PREDICTION IS CODE EXCERPT")
	else
		print("PREDICTION IS TEXT EXCERPT")
	end
end

