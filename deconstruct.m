tic;


%%%%%%% Training set %%%%%%%%%%

rc = cell2mat(review);
bc = cell2mat(business);
uc = cell2mat(user);
cc = cell2mat(checkin);

rdate = mktime(strptime('2013-01-19','%Y-%m-%d'));
rtd = {rc.date};
rta = cellfun(@(x) rdate - mktime(strptime(x,'%Y-%m-%d')) , rtd);

rvc = cell2mat({rc.votes});
rtc = {rc.text};
rtcc = cellfun(@(x) size(x, 2), rtc);

rm = reshape([ rc.stars rtcc rvc.funny rvc.useful rvc.cool rta], size(rc, 1), 6);

rcid = {rc.review_id}';
rcbid = {rc.business_id}';
rcuid = {rc.user_id}';

bm = reshape([ bc.open bc.review_count bc.latitude  bc.longitude  bc.stars  ], size(bc, 1), 5 );
bcid = {bc.business_id}';

uvc = cell2mat({uc.votes});
um = reshape([  uc.average_stars  uc.review_count uvc.funny uvc.useful uvc.cool ], size(uc, 1), 5);
ucid = {uc.user_id}';

cbid = {cc.business_id}';
cm = cellfun(@(x) sum(cell2mat(struct2cell(x.checkin_info))), checkin);



%%%%%%%%% Test set %%%%%%%%%%

trc = cell2mat(test_review');
tbc = cell2mat(test_business');
tuc = cell2mat(test_user');
tcc = cell2mat(test_checkin');

trdate = mktime(strptime('2013-03-12','%Y-%m-%d'));
trtd = {trc.date};
trta = cellfun(@(x) trdate - mktime(strptime(x,'%Y-%m-%d')) , trtd);

trtc = {trc.text};
trtcc = cellfun(@(x) size(x, 2), trtc);

trm = reshape([ trc.stars trtcc trta ], size(trc, 1), 3);
trcid = {trc.review_id}';
trcbid = {trc.business_id}';
trcuid = {trc.user_id}';

tbm = reshape([ tbc.open tbc.review_count tbc.latitude  tbc.longitude  tbc.stars  ], size(tbc, 1), 5 );
tbcid = {tbc.business_id}';

tum = reshape([  tuc.average_stars  tuc.review_count  ], size(tuc, 1), 2);
tucid = {tuc.user_id}';

tcbid = {tcc.business_id}';
tcm = cellfun(@(x) sum(cell2mat(struct2cell(x.checkin_info))), test_checkin');



%%%%%%% Combined set %%%%%%%%%%%%

abcid = concat_cell_array(bcid, tbcid);
aucid = concat_cell_array(ucid, tucid);
aruid = concat_cell_array(rcuid, trcuid);
acbid = concat_cell_array(cbid, tcbid);

abm = concat_matrix(bm, tbm);
aum = concat_matrix(um, tum);
acm = concat_matrix(cm, tcm);


toc;

