namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #    user = User.create!(name: "Ciprian",
    #                        email: "cip@trusca.net",
    #                        password: "foobar",
    #                        password_confirmation: "foobar",
    #                        admin: true
    #                       )
    about_article = Article.new(
      title: "Ce e incubator107?",
      text: %{
        <p><span>incubator107 este locul &icirc;n care oricine poate &icirc;nvăța pe oricine orice. Vrem să &icirc;i &icirc;ncurajăm pe oameni să descopere pasiunile și să &icirc;și urmeze vocația, fără să uite desigur să &icirc;mpărtășească cu ceilalți tot ce au descoperit! <span>incubator107 este un proiect al asociației culturale Macaz. Așteptăm propuneri de ateliere inedite, personale și cu suflet din orice domeniu al vieții de-după-birou. Meșterii noștri pot fi pasionați, inițiați sau experți. Funcționăm din donațiile &icirc;nvățăceilor pe care le &icirc;mpărțim &icirc;n trei - spre meșteri, facturi &amp; materialele pentru ateliere și echipa incubator107.&nbsp;</span><br /><br /><span>Fiecare lună &icirc;ncepe cu c&acirc;te o No</span><span class="text_exposed_show">cturnă unde experimentăm r&acirc;nd pe r&acirc;nd toate atelierele din luna ce urmează. Invitații noștri vin cu merinde făcute &icirc;n casă, trec din experiență &icirc;n experiență și se &icirc;nscriu la atelierele care i-au convins. La răsărit de soare avem c&acirc;ntare și cafea la oală.<br /><br />incubator107 a pornit &icirc;n mansarda unei case &icirc;n aprilie 2011 și pentru că noi credem că e nevoie de un incubator &icirc;n fiecare oraș, am pornit caravana prin Rom&acirc;nia. Am găsit &icirc;n Iași (din aprilie 2012), Cluj (din mai 2012), Timișoara (din iulie 2012), Brașov (din octombrie 2012), Oradea (aprilie 2013), Craiova (din ianuarie 2014) și Sibiu (din martie 2014) echipe descurcărețe care au pornit incubator107 la ei &icirc;n oraș. Dacă ești din alt oraș și crezi că poți coordona un incubator, cheamă-ne!</span></span></p>
        <p>&nbsp;</p>
        <p><iframe src="http://www.youtube.com/embed/LbeYQuxQw70" frameborder="0" width="560" height="315"></iframe></p>
        <p>&nbsp;</p>
        <p><iframe src="http://www.youtube.com/embed/DeaFYa5EToQ" frameborder="0" width="560" height="315"></iframe></p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p><iframe src="http://www.youtube.com/embed/IrM8hkOpmX0" frameborder="0" width="560" height="315"></iframe></p>
      }
    )

    about_article.translation_for(:en).title =
      Globalize.with_locale(:en) do
      about_article.title = "What is incubatod107?"
      about_article.text = %{
        <p>incubator107 is the place where anyone can learn and teach anybody anything. The main values of incubator107 are: non formal education, community and passion.</p>
        <p>As a project of Macaz Association, incubator107 encourages people from the local community to discover their passions and to follow their calling. Passionate people from the community take courage and decide to share their hobbies, skills and talents. Each month incubator107 launches a new set of 10-12 different workshops with meetings for each day. The new workshops are launched at the beginning of the month with an opening event, where we also throw concerts, performances or demonstrations.</p>
        <p>The project is self-sustainable through donations of the participants and the time donated by the volunteers. The donations are split in 3: one part goes to the trainer, one to the project (that covers materials and utility costs for the space) and one part for the organizing team.</p>
        <p>The workshops are part of 10 guilds: Crafters Guild (handmade creations, crafting and building workshops), Movers Guild (dance and sports workshops), Vociferators Guild (musical, theatre and communication workshops), Discoverers Guild (personal and professional development workshops), Travelers Guild, Hedonists Guild (workshops related to beauty, massage and games), Culinary Guild, Children Guild, Wizards Guild (spirituality workshops) and Mentors Guild.</p>
        <p><iframe style="display: block; margin-left: auto; margin-right: auto;" src="http://www.youtube.com/embed/IrM8hkOpmX0" frameborder="0" width="560" height="315"></iframe></p>
        <p>&nbsp;</p>
        <p>incubator107 means discovering the potential in a community and then finding the places and opportunities in which these trainers can grow. incubator107 is present to the biggest festivals in the country, collaborates with institutions, NGOs and companies so that the talent discovered is shared in as many directions as possible.</p>
        <p>incubator107 encourages the trainers and the entire community to follow their vocation and to make a living out of it. Each year we organize the Quit Your Job Project, where psychologists, entrepreneurs, coaches and trainers offer tools for discovering your vocation, growing your entrepreneurial spirit and easing the transition from a profession or industry to another.</p>
        <p>How can you franchise this project in your country?</p>
        <p>To receive the incubator107 franchise you need an enthusiastic and organized team of 4 local coordinators and an NGO to support the initiative. You must find a public or private space where the daily workshops and monthly opening events will take place. If you are interested, tell us right away: noi@incubator107.com.</p>
        <p>Currently incubator107 has 7 franchises in Romania: Cluj, Timisoara, Iasi, Brasov, Oradea, Craiova and Sibiu. The long term strategy of incubator107 is to expend beyond the borders, offering this example of a sustainable project in other countries as well. With the help of Youth in Action funding programme, incubator107 has organized an EVS (European Voluntary Service) project through which 2 volunteers (from Italy and Austria) have analyzed and experimented the incubator107 model and the way it's implemented in 5 of the partner cities over a period of 8 months.</p>
        <p>&nbsp;</p>
        <p><iframe style="display: block; margin-left: auto; margin-right: auto;" src="http://www.youtube.com/embed/eGsJosmvDW4" frameborder="0" width="560" height="315"></iframe></p>
      }
      about_article.save
      end                   


    collaboration_article = Article.create!(
      title: "Colaborări",
      text: %{
        <p><span style="font-size: small;"><strong><span lang="RO">PROGRAMUL DE DESCOPERIRE A PASIUNILOR</span></strong></span></p>
        <p><span lang="RO">Programul este g&acirc;ndit pentru angajații companiilor cărora le pasă de angajații lor. Dacă echipa ta pare plictisită, nemulțumită și cam sedentară, echipa noastră de meșteri &icirc;i ajută să-și redescopere creativitatea, inventivitatea, spiritul de echipă, dorința de a primi provocări și de a se redescoperi.</span></p>
        <p><span lang="RO">&Icirc;n fiecare lună venim cu un maraton de ateliere din cele 6 bresle creative și vă punem la experimentat, căutat și macerat.</span></p>
        <p><span lang="RO">Am implementat cu pasiune acest program &icirc;n cadrul Orange Rom&acirc;nia și Ubisoft.</span></p>
        <div><object style="width: 420px; height: 158px;" width="320" height="240" data="http://static.issuu.com/webembed/viewers/style1/v2/IssuuReader.swf" type="application/x-shockwave-flash"><param name="allowfullscreen" value="true" /><param name="menu" value="false" /><param name="wmode" value="transparent" /><param name="src" value="http://static.issuu.com/webembed/viewers/style1/v2/IssuuReader.swf" /><param name="flashvars" value="mode=mini&amp;embedBackground=%23000000&amp;backgroundColor=%23222222&amp;documentId=121112214545-473446e5eff74d28b7f33b4f4616f9e4" /></object></div>
        <p><span lang="RO">&nbsp;</span></p>
        <p><span style="font-size: small;"><strong><span lang="RO">CAMPANII, EVENIMENTE ȘI PROIECTE</span></strong></span></p>
        <p><span lang="RO"><img src="https://lh6.googleusercontent.com/-9_3I5CtQjkU/UI5QywKcUuI/AAAAAAAAOY8/ZBLwY47xdds/s144/LOGO%2520incubator107-2.jpg" alt="" width="90" height="26" />&nbsp;este un colectiv de 200 de meșteri pasionați care pot veni &icirc;n &icirc;nt&acirc;mpinarea proiectului tău: fie că este o petrecere a companiei, o campanie, o activare &icirc;n mijlocul orașului, o nuntă sau un proiect cultural. Funcționăm ca o agenție de talente care și-a extins tentaculele dincolo de teritoriul artelor spectaculare.</span></p>
        <p><span lang="RO">Am colaborat nebunește cu Grolsch, Orange Rom&acirc;nia, Danone, Milupa, Nestea.</span></p>
        <p><iframe src="http://www.youtube.com/embed/eGsJosmvDW4" frameborder="0" width="560" height="315"></iframe></p>
      }
    )

    your_place_article = Article.create!(
      title: "Locul tău",
      text: %{
        <h3 class="odd">POȚI FI MEȘTER</h3>
        <p>Ești un&nbsp;<span class="even">pasionat</span>&nbsp;<strong><span class="odd">priceput</span></strong>&nbsp;sau un<span class="even">&nbsp;priceput&nbsp;</span><strong><span class="odd">pasionat</span></strong>&nbsp;și vrei să devii<strong><span class="odd">&nbsp;și&nbsp;</span></strong>mai&nbsp;<span class="even"><strong>și&nbsp;</strong></span>&icirc;nvăț&acirc;ndu-i pe alții? Așteptăm propuneri de ateliere pentru: comunitatea noastră t&acirc;nără și frumoasă, copii și străini (ateliere &icirc;n limba engleză sau franceză).&nbsp;Atelierele pot avea o durată de cel mult o lună.&nbsp;Nu&nbsp;te da cotit&nbsp;şi trimite-ne propunerea ta de atelier la <a href="mailto:mesteri@incubator107.com">mesteri@incubator107.com</a>.</p>
        <h3 class="odd">POȚI FI ARTIST</h3>
        <p>* Dacă ești talentat și vrei să ne ajuți &ndash; căutăm pe cineva care să ne ajute să dăm linie și culoare incubatorului &ndash;&nbsp;<span class="even">design&nbsp;</span>pentru&nbsp; afișele care vestesc deschiderile lunare.</p>
        <p>* Dacă ești pasionat de&nbsp;<span class="odd">fotografie&nbsp;</span>sau de&nbsp;<span class="even">film</span>&nbsp;&ndash; hai să &icirc;ți faci m&acirc;na pe noi &ndash; &icirc;n timpul atelierelor noastre poți surprinde bucuria celui care &icirc;nvață ceva, greșelile, grupurile, călătoriile. Hai să creștem &icirc;mpreună și ajută-ne să facem o arhivă a devenirii noastre.</p>
        <h3 class="odd">POȚI FI UCENIC</h3>
        <p>* Vrei să fii&nbsp;<span class="even">voluntarul</span>&nbsp;nostru?&nbsp;Anunță-ne la <a href="mailto:noi@incubator107.com">noi@incubator107.com</a>, vino la ateliere, &icirc;nvață cot la cot cu noi si &icirc;n ceva timp &icirc;și dăm pe m&acirc;nă coordonarea unui atelier (bați palma cu un meșter, &icirc;l ajuți să pună cap la cap ce vrea să ne &icirc;nvețe, faci rost de materiale, promovezi atelierul &icirc;n locuri nebănuite, ești pe fază și săritor la atelier și deschidere, faci fotografii și te bucuri că totul s-a terminat cu bine). Și apoi, o luăm de la capăt!</p>
        <h3 class="odd">POȚI FI VESTITOR</h3>
        <p>* Dacă ai un<span class="even">&nbsp;blog</span>, un&nbsp;<span class="odd">site</span>&nbsp;sau pur și simplu mulți prieteni cărora le-ar plăcea de noi &ndash; dă vestea mai departe, vorbește despre noi, despre evenimentele noastre, despre ateliere și despre spiritul incubator107.</p>
        <p>* Dacă vii la un atelier sau &icirc;ți place ideea poți să&nbsp;<span class="even">*ADOPȚI UN ATELIER*&nbsp;</span>- adică să &icirc;l promovezi la tine pe facebook, să &icirc;ți inviți gașca, să &icirc;l promovezi &icirc;n cafeneaua ta preferată sau pe site-ul tău fetiș.</p>
        <h3 class="odd">POȚI FI SUPERMAN</h3>
        <p>* Dacă ești un bun negociator, un bun conector, un bun colector și un om bun, &icirc;n general &ndash; ajută-ne să găsim&nbsp;<span class="even">sponsorizări &icirc;n natură&nbsp;</span>pentru deschiderile lunare și pentru ateliere.&nbsp;</p>
        <p>* Dacă ai primit mai mult dec&acirc;t sperai, dacă vrei și crezi &icirc;n noi, fii super-eroul nostru și exprimă-te liber &icirc;n c<span>ontul nostru cu arginți: <span>RO09RNCB0074130522510001</span><br /></span></p>
      }
    )

    friends_article = Article.create!(
      title: "Prieteni",
      text: %{
        <div id="accordion">
        <h2 class="odd">&#160;RFI</h2>
        <div>
        <div class="bx">
        <div><a href="http://www.rfi.ro/"> <img style="float: left;" title="RFI" src="http://www.adplayers.ro/files/article_pictures/rfi_logo.jpg" alt="" width="120" />&#160; </a><span style="font-family: 'times new roman', times; font-size: small;">Radio France Internationale. Actualitatea local&#259;, na&#539;ional&#259; &#537;i interna&#539;ional&#259; din politic&#259;, economie, cultur&#259; &#537;i societate.</span></div>
        &#160;</div>
        <div class="bx">
        <h2 class="odd">&#160;Metropotam</h2>
        <div><img style="float: left;" src="http://turn.ro/wp-content/uploads/2011/01/metropotam_mic.jpg" alt="" width="120" />&#160;&#160;<span>Animal urban &icirc;n libertate. Metropotam este revista online actualizat&#259; zi de zi cu articole despre evenimente, locuri &#537;i &icirc;nt&acirc;mpl&#259;ri din Bucure&#537;ti &#537;i din &#539;ar&#259;, recomand&#259;ri, filme, lans&#259;ri, recenzii &#537;i mult&#259; interac&#539;iune.&#160;</span><br /><br /></div>
        <div>&#160;</div>
        </div>
        <div class="bx">
        <h2 class="odd">&#160;Ginger Group</h2>
        <div><a href="http://gingergroup.ro/"> <img style="float: left;" title="Ginger Group" src="https://lh6.googleusercontent.com/-JN2QPRu1bgU/TigWwk7n9CI/AAAAAAAAE0g/8slQ-yxLLS0/s128/logo.png" alt="Ginger Group" />&#160; </a> <span style="font-family: times new roman,times; font-size: small;">Un plus de subiectivism pe scena socio-cultural&#259;, misiunea &icirc;ntregului proiect fiind de a promova oameni, idei &#351;i acte culturale c&#259;tre publicul larg.</span></div>
        </div>
        &#160;
        <div class="bx">
        <h2 class="odd">&#160;&#160;Cursuri &#537;i Certific&#259;ri</h2>
        <div><a href="http://cursurisicertificari.ro/"> <img style="float: left;" title="CURSURI SI CALIFICARI" src="https://lh4.googleusercontent.com/-_JKgI0ZdW9Q/TigWz2sQmaI/AAAAAAAAE0k/3NglEQmUlvU/s128/logo_white.jpg" alt="CURSURI SI CALIFICARI" />&#160; </a><span style="font-family: times new roman,times; font-size: small;"> Cele mai noi &#537;i importante cursuri, traininguri, certific&#259;ri na&#539;ionale &#537;i interna&#539;ionale, programe MBA, workshop-uri, seminarii, sesiuni de dezvoltare profesional&#259; &#537;i/sau personal&#259; etc. care au loc &icirc;n Rom&acirc;nia.</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">&#160;Rom&acirc;nia pozitiv&#259;</h2>
        <p><a href="http://www.RomaniaPozitiva.ro/"> <img style="float: left;" src="https://lh5.googleusercontent.com/-djfBrHacfA8/TigW7G2MhSI/AAAAAAAAE0o/i7smemZUqvY/s128/logo-romaniapozitia%2525202010.jpg" alt="" width="128" height="52" /></a><span style="color: #454545; font-family: 'times new roman', times; font-size: small;">Platforma cu informa&#355;ii pozitive cu &#351;i despre Rom&acirc;nia. Proiecte, ini&#355;iative, idei de Bine pentru Rom&acirc;nia!</span></p>
        </div>
        <div class="bx">
        <h2 class="odd">&#160;Revista Atelierul</h2>
        <div><a href="http://www.revista-atelierul.ro/"> <img style="float: left;" title="REVISTA ATELIERUL" src="https://lh4.googleusercontent.com/-ETNGov8M4Dk/Tukq2Zs1wJI/AAAAAAAANAk/xzwO_l_QAJk/s128/atelierul.png" alt="REVISTA ATELIERUL" />&#160; </a> <span style="font-family: times new roman,times; font-size: small;">Revista Atelierul este prima revista de handmade din Rom&acirc;nia. Vrem s&#259; promov&#259;m tot ceea ce &icirc;nseamn&#259; handmade de calitate, s&#259; adun&#259;m la un loc obiecte lucrate manual, n&#259;scocite de min&#355;i creative &#351;i m&acirc;ini pricepute, prin intemediul vitrinelor de prezentare virtuale, analizelor de trend &#351;i interviurilor cu artizanii &#351;i designerii pe care &icirc;i admir&#259;m.</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">Radio Republika Verde</h2>
        <div><a href="http://republikaverde.ro/"> <img style="float: left;" title="logo1" src="https://lh6.googleusercontent.com/-jJMSefAzdls/Tmcl9TwdnqI/AAAAAAAAHSQ/rLrc6_jAmMk/s1024/rrv-2000x1200.png" alt="" width="120" height="85" />&#160; </a> <span style="font-family: times new roman,times; font-size: small;">Radio Republika Verde este probabil cel mai mare radio online din Rom&acirc;nia bazat pe voluntariat (peste 20 &icirc;n &icirc;ntreaga tar&#259;), un radio fresh, f&#259;r&#259; moguli, f&#259;r&#259; apartenen&#355;&#259; politic&#259;, sus&#355;inut de oameni simpli. La Radio Republika Verde se aude culoarea verde a comunit&#259;&#355;ii, manifest fm pe frecven&#355;a chill-out-online, anti&#351;abloane verbale, antialergic, antirenun&#355;are, antipanic&#259;.</span></div>
        <div><span style="font-family: times new roman,times; font-size: small;">&#160;</span></div>
        </div>
        </div>
        <div>
        <div class="bx">
        <h2 class="odd">GROLSCH</h2>
        <div><img style="float: left;" title="GROLSCH" src="https://lh6.googleusercontent.com/-sLFyOo2_Pn4/TigWpGORFiI/AAAAAAAAE0c/zeMbv4Nrv8g/s128/Grolsch%252520-%252520proud%252520sponsor%252520of%252520the%252520experimentalists.jpg" alt="GROLSCH" />&#160;&#160;<span style="font-family: 'times new roman', times; font-size: small;">Proud Sponsor of the Experimentalists.&#160;&#160;Grolsch, berea premium olandez&#259;,&#160;&icirc;&#537;i propune s&#259; fie un interlocutor pe m&#259;sura comunit&#259;&#539;ilor creative din Europa &#537;i din lume - mereu apropiat acestui tip de public dinamic, plin de resurse, cu personalitate puternic&#259;, non-conformist &#537;i exigent.</span></div>
        &#160;</div>
        &#160;
        <div class="bx">
        <h2 class="odd">JUGGLER</h2>
        <div><a href="http://www.juggler.ro/ro/"> <img style="float: left;" title="JUGGLER" src="http://profile.ak.fbcdn.net/hprofile-ak-snc4/41565_147476108622531_870_n.jpg" alt="JUGGLER" width="130" height="29" />&#160; </a> <span style="font-family: times new roman,times; font-size: small;">Un spa&#539;iu al jonglerului rom&acirc;n, cu informa&#539;ii utile despre articole de jonglat, &#160;companii de productie &#537;i evenimente, din &#539;ar&#259; sau str&#259;in&#259;tate. Hai la joac&#259;!</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">LUME BUN&#258;</h2>
        <div>&#160;<a href="http://www.lumebuna.ro/"><img style="float: left;" title="LUME BUNA" src="https://lh4.googleusercontent.com/-Kf2g6H2tulg/Tukq3bHZS-I/AAAAAAAANBA/6GVdPy_GzXg/s128/lumebuna.jpg" alt="LUME BUNA" /> </a><span><span style="font-family: times new roman,times; font-size: small;">&#350;tiri pozitive.&#160;Viziunea<span>&#160;noastr&#259; este s&#259; repozi&#539;ion&#259;m binele &icirc;n via&#539;a rom&acirc;nilor, &#537;i astfel s&#259; fim mai &icirc;ncrez&#259;tori &icirc;n noi &icirc;n&#537;ine, ca indivizi &#537;i ca na&#539;iune. Doar a&#537;a vom putea produce schimb&#259;rile de care aceast&#259; &#539;ar&#259; are nevoie.</span></span><br /></span></div>
        </div>
        <div class="bx">&#160;
        <h2 class="odd">AIESEC</h2>
        <div><a href="http://www.aiesec.ro/"> <img style="float: left;" title="AIESEC" src="http://www.aiesec.net/cms/aiesec/images/logo.png" alt="AIESEC" width="120" />&#160;</a>&#160;<span style="font-family: 'times new roman', times; font-size: small;">AIESEC este cea mai mare re&#539;ea de studen&#355;i din lume, cu peste&#160;60&#160;000 de membri&#160;din 110 &#355;&#259;ri &#537;i teritorii.&#160;</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">ICR</h2>
        <div><a href="http://www.icr.ro/bucuresti/"> <img style="float: left;" title="ICR" src="https://lh4.googleusercontent.com/-lNPpWtz6Kq0/TpaM6GwlVtI/AAAAAAAAJg0/w6UDEV5qzAU/s174/ICR.jpg" alt="ICR" width="120" />&#160; </a> <span style="font-family: times new roman,times; font-size: small;">Misiunea Institutului Cultural Rom&acirc;n este promovarea culturii &#351;i civiliza&#355;iei na&#355;ionale &icirc;n &#355;ar&#259; &#351;i &icirc;n afara ei. Cre&#351;terea vizibilit&#259;&#355;ii valorilor culturale rom&acirc;ne&#351;ti &icirc;n lume constituie scopul principal al activit&#259;&#355;ilor desf&#259;&#351;urate de ICR.&#160;</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">MNAC</h2>
        <p><a href="http://www.mnac.ro/events%20main_ro.htm"> <img style="float: left;" title="logo1" src="http://www.mnac.ro/sigle_sit/mnac.jpg" alt="" width="120" /></a><span style="color: #222222; font-family: 'times new roman', times; font-size: small;">Muzeul Na&#539;ional de Art&#259; Contemporan&#259;</span></p>
        </div>
        <div class="bx">
        <h2 class="odd">PROFIART</h2>
        <div><a href="http://www.profiart.ro/"> <img style="float: left;" title="logo1" src="https://lh5.googleusercontent.com/-Im5rG6rRc04/Tukq3iTpQbI/AAAAAAAANA8/5o3hKj6x5Tw/s128/profiart.png" alt="" width="128" height="51" />&#160; </a> <span style="font-family: times new roman,times; font-size: small;"><strong>Art &amp; Hobby Center </strong>reprezint&#259; oferta de frumos, pia&#539;a de art&#259;, marketul celor care ne bucur&#259; sufletul &#537;i ne m&acirc;ng&acirc;ie privirile &ndash; pictorii, decoratorii, designerii &#537;i me&#537;te&#537;ugarii.</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">Spic&amp;Bob</h2>
        <div><a href="http://www.spicsibob.ro/?page_id=2"> <img style="float: left;" title="logo1" src="https://lh4.googleusercontent.com/-Nk9OXxxQRFk/TmDIXJLrxPI/AAAAAAAAHGU/BjF6BICb5iI/S%252526B.png" alt="" width="120" /></a></div>
        <div><span style="font-family: times new roman,times; font-size: small;">&#160;Spic&amp;Bob s-au &icirc;nt&acirc;lnit pentru a pune la copt cele mai gustoase, hr&#259;nitoare &#351;i nutritive produse de brut&#259;rie, patiserie &#351;i cofet&#259;rie.</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">&#160;Demmers TeeHaus</h2>
        <div><a href="http://demmers.ro/"> <img style="float: left;" title="logo1" src="https://lh3.googleusercontent.com/-j3SgDN0rhIo/ToLYLM6s3nI/AAAAAAAAHp4/x-csiVY7L50/logo%252520bun.png" alt="" width="120" />&#160; </a><span style="font-family: times new roman,times; font-size: small;"> La DEMMERS TEEHAUS Academiei, g&#259;se&#351;ti peste 200 de sortimente de ceai vrac, accesorii potrivite &#351;i bun&#259;t&#259;&#355;i fel de fel. Te a&#351;tept&#259;m de Luni p&acirc;n&#259; S&acirc;mb&#259;t&#259; &icirc;ntre orele 10:00 &#351;i 20:00 cu arome minunate, tradi&#355;ii deosebite, accesorii &#351;i dulciuri nemaipomenite!</span></div>
        </div>
        <div class="bx">
        <h2 class="odd">TEDx</h2>
        <p><img style="float: left;" title="logo1" src="http://spoutingoff.files.wordpress.com/2010/11/tedxlogo.jpg" alt="" width="120" /><span style="font-family: 'times new roman', times; font-size: small;">Ideas worth spreading.&#160;TED este un eveniment anual unde sunt invita&#539;i unii dintre cei mai importan&#539;i g&acirc;nditori &#537;i creativi ai lumii s&#259; &icirc;mp&#259;rt&#259;&#537;easc&#259; lucrurile de care sunt pasiona&#539;i. TED sunt ini&#539;ialele de la Technology, Entertainment, Design &mdash; trei domenii largi care combinate ne influen&#539;eaz&#259; viitorul.</span></p>
        <div><span style="color: #222222; font-family: 'times new roman', times; font-size: x-small;">&#160;</span></div>
        </div>
        <h2 class="odd">Radio Guerrilla&#160;&#160;&#160;</h2>
        <p><img style="float: left;" title="Radio Guerrilla" src="https://lh5.googleusercontent.com/-Rsrwq332azQ/TvLvKCVenSI/AAAAAAAANB0/po8nrUs2_w8/s414/logo-Radio-Guerrilla.jpg" alt="Radio Guerrilla" width="120" height="90" /></p>
        <span style="color: #222222; font-family: 'times new roman', times; font-size: small;">Radio Guerrilla, o forma&#355;iune de eliberare a radioului de sub teroarea amor&#355;irii, a lipsei de comunicare real&#259;, care urmareste instaurarea st&#259;rii de normalitate a dialogului, a bucuriei jocului, a inventivit&#259;&#355;ii &#351;i empatiei. Un radio premium, care si-a propus sa fie adult &icirc;n con&#355;inut, personalitate, stil de revolt&#259;, atitudine, informa&#355;ie &#351;i muzic&#259;.&#160;Facem din muzic&#259; o arm&#259; &#537;i lovim cu cele mai bune piese, &icirc;naintea tuturor...</span>
        <h2 class="odd">&#160;Odaia Creativ&#259;</h2>
        <p><img style="float: left;" title="Odaia Creativa" src="https://lh5.googleusercontent.com/-cn1XLAokvdU/TvLvKHfq26I/AAAAAAAANBY/ZPm2rEU0kkM/s250/Odaia-Creativa.jpg" alt="" width="120" height="43" /><span style="color: #666666; font-family: 'times new roman', times; font-size: small;"><span style="line-height: 18px;">Sus&#355;inem proiectele de&#160;<strong>economie creativ&#259;</strong>. Recunoa&#351;tem poten&#355;ialul local al me&#351;te&#351;ugurilor, ecoturismului &#351;i turismului&#160; cultural, &icirc;ncuraj&#259;m spiritul comunitar &#351;i formarea resurselor umane la nivel local.</span></span></p>
        <h2 class="odd">ROPOT</h2>
        <p><img style="float: left;" title="Ropot" src="https://lh3.googleusercontent.com/-ZHnKRBxYNnA/TvLvKrviHmI/AAAAAAAANBg/psv9_-_haCg/s712/ropot-sigla.jpg" alt="" width="120" height="77" /></p>
        <p>&#160;<span style="font-family: 'times new roman', times; font-size: small;">Comunitate. Dezvoltare. Incubator.&#160;O comunitate de oameni cu interese comune &icirc;n zona de antreprenoriat social, o platform&#259; de conectare ce devine o comunitate de practic&#259; bazat&#259; pe &icirc;ncredere, respect &#537;i contribu&#539;ie.&#160;Un incubator de proiecte de antreprenoriat social pe care le sus&#539;inem &icirc;n a deveni sustenabile.</span></p>
        <h3>&#160;CROS</h3>
        <p><img style="float: left;" title="CROSS" src="https://lh3.googleusercontent.com/-O6J6is3BR20/TvLvLM4wG4I/AAAAAAAANBo/SPcq9iBdF0k/s300/sigla%252520CROS.png" alt="" width="120" height="120" /></p>
        <p>&#160;</p>
        <p><span style="font-family: 'times new roman', times; font-size: small;">Centrul de Resurse pentru Organiza&#355;ii studen&#355;e&#351;ti.&#160;Revolu&#539;ia educa&#539;iei.&#160;CROS este o organiza&#355;ie de tineret dedicat&#259; organiza&#355;iilor studen&#355;e&#351;ti &#351;i voluntarilor ac Centrul de Resurse pentru Organiza&#355;ii studen&#355;e&#351;ti.&#160;Revolu&#539;ia educa&#539;iei.&#160;CROS este o organiza&#355;ie de tineret dedicat&#259; organiza&#355;iilor studen&#355;e&#351;ti &#351;i voluntarilor acestora. Misiunea CROS este s&#259; creasc&#259; impactul celor peste 200 de organiza&#355;ii studen&#355;e&#351;ti din Rom&acirc;nia. &Icirc;n acest scop, ajut&#259;m ONGS-urile s&#259; fac&#259; proiecte mai bune, mai bine &#351;i c&#259;ut&#259;m s&#259; &icirc;mbog&#259;&#355;im experien&#355;a de &icirc;nv&#259;&#355;are a membrilor.</span></p>
        <h2 class="odd">Advice</h2>
        <p><span style="color: #222222; font-family: arial,helvetica,sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal; line-height: 19px; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; background-color: #ffffff; display: inline ! important; float: none;"><img style="float: left;" title="ADVICE" src="https://lh5.googleusercontent.com/-FCYbBBfsUjc/TvQ6KmXG0nI/AAAAAAAANCE/KM2WaXhycGE/s160/photo_small-16574.jpg" alt="" width="100" height="100" /></span></p>
        <div style="text-align: left;"><span style="color: #333333; font-family: 'times new roman', times; font-size: small;"><span style="line-height: 14px;">Suntem prima organiza&#355;ie studen&#355;easc&#259; implicat&#259; &icirc;n dezvoltarea industriei creative, prin proiectele pe care le realiz&#259;m &#351;i oamenii pe care &icirc;i form&#259;m, intern sau &icirc;n cadrul proiectelor. Suntem ambi&#355;io&#351;i &#351;i avem planuri mari de viitori, iar asta rezult&#259; din viziunea pe termen lung pe care o avem.&#160;<br />Viziunea noastr&#259; este: To become the main open source platform and practice hub for students and to take part in the development of the creative industry.</span></span></div>
        <p>&#160;</p>
        <h2>Life after work</h2>
        <p><span style="color: #222222; font-family: arial,helvetica,sans-serif; font-size: 12px; font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal; line-height: 19px; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; background-color: #ffffff; display: inline ! important; float: none;"><img style="float: left;" title="Life after work" src="https://lh3.googleusercontent.com/-j0vkk_cTXf4/TvQ6NNfCx8I/AAAAAAAANCM/XhRC4Hs9BQo/s648/Life%252520After%252520Work%252520Final%252520CS%2525202.jpg" alt="" width="120" height="95" /></span></p>
        <p><span style="color: #222222; font-size: small; font-family: 'times new roman', times;">It's all a big playground!&#160;Life after Work a luat fiin&#539;&#259; &icirc;n 2009, din lipsa de culoare a lumii multor oameni &#537;i din senza&#539;ia c&#259; &icirc;nv&#259;&#539;area continu&#259; poate fi privit&#259; drept un ideal realizabil &#537;i pl&#259;cut, nu doar un concept care sun&#259; din ce &icirc;n ce mai rece.&#160;Workshopuri fun &#537;i interactive, petreceri de copii, evenimente corporate, traininguri &#537;i team buildinguri.</span></p>
        <h2 class="odd">HOBISTI.RO</h2>
        <p><a href="http://www.hobisti.ro/"><img style="float: left;" title="HOBISTI.RO" src="https://lh3.googleusercontent.com/-2acocv_fVJQ/TyMOSn7dlzI/AAAAAAAANF0/u_S9ooldNqU/s144/sigla%2520color%2520TEXT.jpg" alt="HOBISTI.RO" width="100" /></a><span style="font-family: 'times new roman', times; font-size: small;">Hobisti.ro este locul de &icirc;nt&acirc;lnire pentru fiecare om care are un hobby sau care vrea s&#259; &icirc;&#537;i g&#259;seasc&#259; unul. Un site proactiv &#537;i interactiv, inedit &#537;i complex care ordoneaz&#259; &icirc;n jurul ideii de HOBBY un &icirc;ntreg univers de resurse: Loca&#539;ii dedicate; Magazine&#160;cu accesorii &#537;i echipamente; Cursuri&#160;&#537;i&#160;Evenimente; Comunitatea hobi&#537;tilor&#160;FORUM, Articole &#537;i &#537;tiri, Jocuri online.&#160;</span><span style="font-family: 'times new roman', times; font-size: small;">Teste cu &icirc;ntreb&#259;ri despre hobby-uri</span><span style="font-family: 'times new roman', times; font-size: small;">; &icirc;ntr-un design creativ, vesel &#537;i prietenos.</span></p>
        <h2 class="odd">&#160;</h2>
        <h2 class="odd">The Coca Cola Company</h2>
        <p><img style="float: left;" src="https://lh4.googleusercontent.com/--XXdJrncsfs/TyMSmLbMy1I/AAAAAAAANGA/F867QcCkiwQ/s144/header-logo.png" alt="" width="180" />&#160;&#160;<span style="font-family: 'times new roman', times; font-size: small;">Misiunea companiei Coca-Cola este aceea de a aduce un minut de pl&#259;cere&#160;oamenilor de peste tot din lume, de a le d&#259;rui gustul r&#259;coritor. Coca-Cola nu este doar o&#160;b&#259;utur&#259;, ea a devenit un simbol al prieteniei, prezent&#259; &icirc;n via&#539;a oamenilor &icirc;n fiecare zi, dar &icirc;n special de s&#259;rb&#259;tori.&#160;Coca-Cola &icirc;nseamn&#259; solidaritate, optimism, prosperitate, inova&#539;ie.</span></p>
        <div>
        <h2 class="odd">Papa Jacques</h2>
        </div>
        <p><a href="http://www.papajacques.ro/"><img style="float: left;" title="PAPA JACQUES" src="https://lh6.googleusercontent.com/-eyKIli4yPpA/TyMUWK8G2gI/AAAAAAAANGM/QnrzJ2WoU-E/s144/logo%2520Papa%2520Jacques.jpg" alt="" width="90" /></a><span style="font-family: 'times new roman', times; font-size: small;">Am creat un produs a&#537;a cum ni l-am dorit pentru noi: boabe verzi de cafea de specialitate produse &icirc;n ferme &#537;i planta&#539;ii de cafea pe care le putem localiza geografic, pr&#259;jite dar nu arse, &icirc;n pungi concepute astfel &icirc;nc&acirc;t s&#259; aib&#259; un impact c&acirc;t mai mic asupra mediului &icirc;nconjur&#259;tor.</span></p>
        <div class="bx">&#160;</div>
        </div>
        </div>
        <h2 class="odd">Teadvisor</h2>
        <p><a href="http://teadvisor.blogspot.com/"><img style="float: left;" title="TEADVISOR" src="https://lh4.googleusercontent.com/-Bu6KG7Qk_Ek/TyMVpszWXrI/AAAAAAAANGY/3dlPNc4rui0/s144/logo%2520tea%2520mihai%2520final.png" alt="" width="90" /></a><span style="font-family: 'times new roman', times; font-size: small;">Din suflet pentru ceai &#537;i ceaiuri pentru suflet. A&#537;a a &icirc;nceput Teadvisor, un blog despre cum s&#259; savurezi ceaiuri, care acum a devenit magazinul on-line cu o colec&#539;ie impresionant&#259; de ceaiuri de origine &#537;i comori aromatizate, accesorii &#537;i produse de confiserie.</span></p>
        <div class="bx">&#160;&#160;</div>
        <h2 class="odd">Roaba de cultur&#259;</h2>
        <p><a href="http://www.greenrevolution.ro/proiecte/detaliu.php?id=21"><img style="float: left;" title="ROABA DE CULTUR&#258;" src="https://lh6.googleusercontent.com/-6aDDBAJ12NI/TzGgf8WJcFI/AAAAAAAANIs/saptb3r4K4k/s144/roaba.jpg" alt="" width="90" /></a><span style="font-family: 'times new roman', times; font-size: small;">Proiectul &ldquo;Roaba de cultur&#259;&rdquo; ofer&#259; &icirc;n mod gratuit alternative culturale pentru petrecerea timpului liber &icirc;n natur&#259;. Re&icirc;nnoad&#259; rela&#539;ia om-cultur&#259;-natur&#259;, l&#259;s&acirc;nd posibilitatea oamenilor de a se implica direct sau de a asista la numeroase programe printre care: lectur&#259;, filme, dans, concerte, cursuri de desen &#537;i ol&#259;rit, evenimente sportive.</span></p>
        <div class="bx">&#160;&#160;</div>
        <h2 class="odd">Revista LZR</h2>
        <p><a href="http://revistalzr.ro/"><img style="float: left;" title="Revista LZR" src="https://lh6.googleusercontent.com/-J_qgsvxMS4o/TzGiRaFTt9I/AAAAAAAANI4/5Ard2Pi4dtQ/s800/lzr.jpg" alt="" width="90" /></a><span style="font-family: 'times new roman', times; font-size: small;">LZR este revista &#8222;Colegiului Na&#539;ional Gheorghe Laz&#259;r Bucure&#537;ti&rdquo; &#537;i a luat na&#537;tere &icirc;n toamna lui 2010, din dorin&#539;a de a aduce o schimbare, c&acirc;t &#537;i de a promova noi idei. De atunci, revista a avut 5 numere print, iar din var&#259; s-a extins &#537;i pe online. LZR promoveaz&#259; creativitatea, originalitatea, inova&#539;ia, iar articolele sunt din ce &icirc;n ce mai variate, de la recenzii de filme, c&#259;r&#539;i, evenimente, p&acirc;n&#259; la interviuri &#537;i articole de promovare.</span></p>
        <h2 class="odd">TRANSPORTURBAN.RO</h2>
        <p><a href="http://www.transporturban.ro" target="_blank"><strong><img style="float: left;" src="https://lh4.googleusercontent.com/-hvNgibU_Jf8/T3MZiOlofGI/AAAAAAAANLg/Zu7gHMXZkM4/s144/sigla_transport_urban-001.jpg" alt="" width="144" height="60" /></strong></a></p>
        <p><span style="font-family: 'times new roman', times; font-size: small;">te ajut&#259; s&#259; c&#259;l&#259;tore&#537;ti rapid &#537;i sigur, folosind mijloacele de transport public din Bucure&#537;ti.</span>&#160;</p>
        <h2 class="odd">Evadeaz&#259;CuNoi</h2>
        <p><a href="http://evadeazacunoi.ro/" target="_blank"><strong><img style="float: left;" src="https://lh3.googleusercontent.com/-gmqtirbZmJM/T48CqWZ-G0I/AAAAAAAANME/j-tO1Sb43dY/s144/160x160px-Logo-Evadeaza.jpg" alt="" width="120" height="120" /></strong></a></p>
        <h2 class="odd"><strong>&#160;</strong></h2>
        <p class="odd"><span style="font-family: 'times new roman', times; font-size: small;">Vrei s&#259; ie&#537;i din cotidian, s&#259; te distrezi &icirc;n grup, <a href="http://evadeazacunoi.ro/">Evadeaz&#259;CuNoi</a>!</span></p>
        <h2 class="odd">C&#259;su&#539;a cu surprize</h2>
        <p><strong><a href="http://casutacusurprize.ro/"><img src="https://lh3.googleusercontent.com/-Qb1COH8-dgk/T3NK47pEoTI/AAAAAAAANLs/E38WRTUjtBo/s144/logo.jpg" alt="" width="144" height="45" /></a>&#160;</strong><a href="http://casutacusurprize.ro/" target="_blank">http://casutacusurprize.ro/</a></p>
        <h2>Single Bell</h2>
        <p><a href="http://singlebell.net/" target="_blank"><img src="https://lh3.googleusercontent.com/-QdUO80Qs2oI/UGQrr9JniJI/AAAAAAAAOJQ/F57-CqHtd-0/s400/sb_v2-full%2520%25281%2529.jpg" alt="" width="150" height="56" /></a>&#160;<a href="http://singlebell.net/">http://singlebell.net/</a></p>      
      }
    )

    two_percent_article = Article.create!(
      title: "2%",
      text: %{
        <div class="entry-content">
        <p><span class="even">incubator</span><strong><span class="odd">107</span></strong> este un proiect al Asociaţiei Culturale <span style="color: #82c639;"><strong>Macaz</strong></span>, asociaţie non-profit (ONG). Dacă doriţi să susţineţi atelierele noastre, mai jos aveţi coordonatele noastre.<br /> Mulţumim!</p>
        <p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&ndash;</p>
        <p><strong>1. Formularul 230 &bdquo;Cerere privind destinaţia sumei reprezent&acirc;nd p&acirc;nă la 2% din impozitul anual&ldquo; cod 14.13.04.13</strong></p>
        <p>Se completează de către persoanele fizice care au realizat, &icirc;n anul 2011, venituri din salarii şi asimilate salariilor şi care solicită virarea unei sume de p&acirc;nă la <span class="even"><strong>2% </strong></span>din impozitul anual, conform art.57 alin.(4) din Legea nr.571/2003 privind Codul fiscal, cu modificările şi completările ulterioare, pentru sponsorizarea entităţilor nonprofit care se &icirc;nfiinţează şi funcţionează potrivit legii. Contribuabilii care &icirc;şi exprimă această <strong><span class="odd">opţiune</span></strong> pot solicita direcţionarea acestei sume către o singură entitate nonprofit. Formularul se completează de către contribuabili, &icirc;nscriind cu majuscule, citeţ şi corect, datele prevăzute de formular.</p>
        <p><strong>2. Formularul 200 &bdquo;Declarație specială privind veniturile realizate&ldquo; cod 14.13.01.13</strong></p>
        <p>Se completează de către persoanele fizice care au realizat, &icirc;n anul 2011, venituri&nbsp;din activităţi independente, cedarea folosinţei bunurilor, transferul titlurilor de valoare, operaţiuni de v&acirc;nzare-cumpărare de valută la termen pe bază de contract, precum şi orice alte operaţiuni similare. Cu <strong><span class="odd">ocazia</span></strong> completării şi depunerii Declaraţiei 200, care &icirc;şi exprimă această opţiune pot solicita direcţionarea către o entitate nonprofit p&acirc;nă la <strong><span class="even">2%</span></strong> din impozitul datorat.&nbsp;Declarația se completează de către contribuabili, &icirc;nscriind cu majuscule, citeţ şi corect, datele prevăzute de formular.</p>
        <p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&ndash;</p>
        <p><em>Termen de depunere:</em></p>
        <p>P&acirc;nă la data de <span style="color: #82c639;"><strong>23 MAI 2014</strong></span>. Formularul se completează &icirc;n două exemplare:- originalul se depune la: a) organul fiscal &icirc;n a cărui <span class="odd"><strong>rază</strong></span> teritorială contribuabilul are adresa undei &icirc;şi are domiciliul potrivit legii sau adresa unde locuieşte efectiv, &icirc;n cazul &icirc;n care aceasta este diferită de domiciliu, pentru persoanele fizice care au domiciliul fiscal &icirc;n Rom&acirc;nia; b) organul fiscal &icirc;n a cărui<span class="odd"><strong> rază</strong></span> teritorială se află sursa de venit, pentru ceilalţi contribuabili persoane fizice; &ndash; copia se păstrează de către contribuabil. Formularul se depune direct la registratura organului fiscal sau la oficiul poştal, prin scrisoare recomandată. Formularul se pune gratuit la dispoziţie contribuabilului, la solicitarea acestuia.</p>
        <p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&ndash;</p>
        <p><em>A. Date de identificare ale contribuabilului</em></p>
        <p>Adresa &ndash; se &icirc;nscrie adresa domiciliului fiscal. Cod numeric personal / Număr de identificare fiscală &ndash; se &icirc;nscrie codul numeric personal din cartea de identitate, respectiv din buletinul de identitate al fiecărui contribuabil sau numărul de identificare fiscală, atribuit de către Ministerul Finanţelor Publice, cu ocazia &icirc;nregistrării fiscale, după caz.</p>
        <p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&ndash;</p>
        <p><em>B. Destinaţia </em>sumei reprezent&acirc;nd p&acirc;nă la <span class="even"><strong>2%</strong></span> din impozitul anual pentru sponsorizarea unei entităţi nonprofit, potrivit dispoziţiilor ART.57 ALIN.(4) DIN LEGEA NR.571/2003.</p>
        <p>Suma &ndash; se completează cu suma solicitată de contribuabil a fi virată &icirc;n contul entităţii nonprofit. &Icirc;n situaţia &icirc;n care contribuabilul nu cunoaşte suma care poate fi virată, nu va completa rubrica &bdquo;Suma&ldquo;, caz &icirc;n care organul fiscal va calcula şi va vira suma admisă, conform legii.</p>
        <p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&ndash;</p>
        <p><em>Denumire entitate nonprofit:</em><br /> Asociaţia Culturală <strong><span style="color: #7fcb34;">MACAZ</span></strong></p>
        <p><em>Cod de identificare fiscală al entităţii nonprofit:</em><br /> C.I.F. 25354070</p>
        <p><em>Cont bancar (IBAN)</em> &ndash; se completează codul IBAN al contului bancar al entităţii nonprofit<br /> Cont IBAN : <strong>RO09RNCB0074130522510001</strong></p>
        <p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&ndash;</p>
        <p>Descarcă:</p>
        <p><strong>- <a href="https://www.dropbox.com/s/9tjmn9f1epbhz3q/formular230%202014%20-%20incubator107%20-%20Asociatia%20Culturala%20MACAZ.pdf" target="_blank">Formularul 230</a></strong>&nbsp;- aplicabil celor care realizează venituri din salarii şi asimilate salariilor;</p>
        <p><strong>- <a href="https://www.dropbox.com/s/8yuay19g94qw19e/formular200%202014%20-%20incubator107%20-%20Asociatia%20Culturala%20MACAZ.pdf" target="_blank">Formularul&nbsp;200</a></strong>&nbsp;-&nbsp;aplicabil celor ale căror venituri provin din activități independente.</p>
        </div>
      }
    )

    News.create!(
      title: 'Nocturna "Punguța cu 2 ani"',
      text: %{
            <p>&Icirc;nvățăcei, meșteri și ucenici haideți să sărbătorim 2 ani de Incubator107 &icirc;n Cluj. Ne vedem &icirc;n data de 17 mai, &icirc;ncep&acirc;nd cu ora 20:00, la Cluj Hub (Pitești nr. 19).</p>
            <p>Năzdrăvanul ucenic<br />De meșter acum a fugit, <br />Ce nu era al lui, acum este<br />Asemenea pățaniei din poveste!</p>
            <p>Ce se află &icirc;n punguță, vă-ntrebați? <br />- rememorăm 2 anișori de incubator clujean;<br />- ne arătați c&acirc;te un lucrușor incubatoricesc meșterit de voi la ateliere;<br />- trecem țanțoș prin atelierele lunii mai: <br />&bull; aflăm despre ce &icirc;nseamnă cu adevărat parkour (meșter Andrei Tompa), <br />&bull; confecționăm Puppets și ne jucăm in the mirror cu Elisa Sarchi, <br />&bull; &icirc;nvățăm să stăm corect la lucru și acasă (ergonomie) și aflăm despre tehnica masajului ( meșteri Daniel Scuturici și Daniela Urs),<br />&bull; brodăm cu Smaranda Chereches, <br />&bull; meșteșugim stickere cu Alex Lazăr și Rus Vlad,<br />&bull; aflăm cum să facem o campanie pentru o cauză cu Victor Miron.<br />- ne bucurăm de mini-spectacolul celor de la Teatru de improvizatie &ndash; ACTitudine<br />- c&acirc;ntare cu Andi (Toy Machines), Floppy &amp; Alex</p>
            <p>Nu uita să ne aduci și tu z&acirc;mbete, povești incubatoricești, merinde pentru masa noastră de bucate și 20 de galbeni ca să ne ajuți Incubatorul să crească.</p>
      },
        release_date: DateTime.now
    )

    City.create!(name: 'Cluj',
                 domain: 'cluj',
                 email: 'cluj@incubator107.com',
                 mailing_list_id: 1,
                 donation: 10,
                 facebook: 'incubator107Cluj',
                 donation: 10, 
                 donation_alternative: %{
                  Dacă nu vă puteți permite, nu stați departe, ne puteți ajuta în alte feluri: să promovăm în companii Programul de descoperire a pasiunilor, să atragem sponsorizări
                 }
                )

    City.create!(name: (I18n.t 'bucharest'),
                 domain: 'bucuresti',
                 email: 'bucuresti@incubator107.com',
                 mailing_list_id: 2,
                 donation: 30,
                 facebook: 'incubator107'

                )

    CityNews.create!( 
                     city_id: 1,
                     news_id: 1
                    )


    # GROUPS


    Group.create(
      name: "Breasla Făuritorilor",
    )

    Group.create(
      name: "Breasla Călătorilor",
    )

    Group.create(
      name: "Breasla Hedoniștilor",
    )

    Group.create(
      name: "Breasla Vrăjitorilor",
    )
    Group.create(
      name: "Breasla Mișcătorilor"
    )

    Group.create(
      name: "Breasla Glăsuitorilor"
    )
    Group.create(
      name: "Breasla Descoperitorilor"
    )
    Group.create(
      name: "Mentor în incubator"
    )
     
    Group.create(
      name: "Breasla Copiilor"
    )

    Group.create(
      name: "nocturna"
    )

    Group.create(
      name: "Breasla Virtualilor"
    )

    Group.create(
      name: "Breasla Culinarilor"
    )





    ### LOCATIONS
    Location.create!(
      city_id: 1,
      name: Faker::Company.name,
      address: Faker::Address.street_address,
      description: Faker::Lorem.sentence,

    )






    CityLink.create!( name: 'about',
                     city_id: 1,
                     article_id: 1)

    CityLink.create!( name: 'collaboration',
                     city_id: 1,
                     article_id: collaboration_article.id)

    CityLink.create!( name: 'your_place',
                     city_id: 1,
                     article_id: your_place_article.id)

    CityLink.create!( name: 'two_percent',
                     city_id: 1,
                     article_id: two_percent_article.id)


    CityLink.create!( name: 'friends',
                     city_id: 1,
                     article_id: friends_article.id)


    CityLink.create!( name: 'contact',
                     city_id: 1,
                     article_id: 2)



    #Workshop.create( 
    #                name: 'Vin sarbatorile',
    #                city_id: 1,
    #                enabled: 1,
    #                release_date: DateTime.now
    #               )
    30.times do |n|
      Workshop.create!(
        name: Faker::Lorem.sentence,
        group_id: 1 + rand(Group.count),
        city_id: 1,
        release_date: DateTime.now,
        album: Faker::Lorem.sentence,
        enabled: true,
        requires_donation: 1,
        should_send_notification: 1, 
        whereabouts: Faker::Lorem.paragraph,
        description: Faker::Lorem.paragraph,
        with_whom: Faker::Lorem.paragraph,
        bring_along: Faker::Lorem.paragraph,
        donation: Faker::Lorem.paragraph,
        notification: Faker::Lorem.paragraph
      )
    end

    100.times do |n|

      Event.create!(
        start_date: DateTime.now.at_beginning_of_month + rand(40).days + rand(24).hours,
        workshop_id: 1+ n%30,
        duration: 120,
        location_id: 1
      )
    end
    #    Workshop.create( 
    #      name: 'disabled workshop',
    #      city_id: 1,
    #      enabled: 0
    #                   )

    #    Workshop.create( name: 'old workshop',
    #                    city_id: 1,
    #                    enabled: 1,
    #                    release_date: 1.month.ago
    #                   )
    #
    #    Workshop.create( name: 'next month workshop',
    #                    city_id: 1,
    #                    enabled: 1,
    #                    release_date: 1.month.from_now
    #                   )




    #    99.times do |n|
    #      name  = Faker::Name.name
    #      email = "example-#{n+1}@railstutorial.org"
    #      password  = "password"
    #      User.create!(name: name,
    #                   email: email,
    #                   password: password,
    #                   password_confirmation: password)

    #    end
  end
end
