# Patient-specific-dental-arch-estimation-via-LASSO-regression-analysis-in-CBCT-image

A significant number of patients suffer from craniomaxillofacial (CMF) deformity and require CMF surgery. The success of CMF surgery
depends on not only the surgical techniques but also accurate surgical planning. However, surgical planning for CMF surgery is challenging
due to the absence of a patient-specific reference model. Currently, the outcome of the surgery is often subjective and highly dependent on
the surgeon’s experience. The purpose of this thesis is to determine a patient-specific reference model that estimates an anatomically
correct reference patient's jaws. Therefore, in spite of the corrected model, it is possible to evaluate the progress of the treatment or
the operation of the surgeon. In order to estimate the corrected model, several multislice computed tomography (MSCT) images of normal
subjects have also been used. Regarding the patient's normal information, we want to calculate the amount of abnormality and estimate its
corrected model. In the proposed method, first, using the methods of appropriate feature extraction, we find the correspondence between the
symmetric properties in the image. Then, by placing the anatomical landmarks and calculating their distances from the axis of symmetry, we
will determine the – rotation- and scale -invariant coordinates of the anatomical landmarks of the MSCT image. By creating a database of
calculated distances from a normal dataset, we obtain the sparse coefficients of the patient's normal part. After applying these
coefficients to the calculated distances of the patient's abnormal jaw, the new distances are obtained, which are the estimated locations
of corrected anatomical landmarks. The amount of abnormality is the difference between estimated distances from the axis of symmetry and
the calculated jaw distances. The system error is calculated by applying the Leave-one-out cross-validation method, and the estimation
parameters are also adjusted with different optimization methods. The proposed method has responded to some maxillofacial deformities such
as dry socket tooth, maxillary-mandibular asymmetry, and abnormalities associated with orthodontic and orthognathic surgery. In this
thesis, a quantitative criterion is presented for assessing the accuracy of symmetry. The accuracy of the axis of symmetry for 13 normal
data was obtained 87%. On average, the mean square error for normal mandibular and maxillary CBCT images was obtained 0.029 and 0.034,
respectively.

the key_select.m is the final file. you run it and click my mouse on the picture to locate the landmarks of the target image and then the estimated landmarks and dental arch will be shown.


cite this paper: O. Ghozatlou and D. R. a. Zoroofi, "Patient-specific dental arch estimation via LASSO regression analysis in CBCT images," 2019 26th National and 4th International Iranian Conference on Biomedical Engineering (ICBME), Tehran, Iran, 2019, pp. 124-128, doi: 10.1109/ICBME49163.2019.9030426.
