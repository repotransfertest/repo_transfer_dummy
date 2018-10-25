
FROM agahkarakuzu/jnbase

RUN npm install -g ijavascript;\
	ijsinstall;

CMD ijs --ip=* --debug

USER root 

RUN cd $HOME/work;\
    pip install octave_kernel sos sos-notebook scipy plotly dash dash_core_components dash_html_components dash_dangerously_set_inner_html dash-renderer flask==0.12.2;\
    python -m sos_notebook.install;\
    git clone --single-branch -b sos-javascript https://github.com/mathieuboudreau/repo_transfer_dummy;\
    cd repo_transfer_dummy;\
    git clone https://github.com/neuropoly/qMRLab.git;\
    chmod -R 777 $HOME/work/repo_transfer_dummy; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

RUN cd $HOME/work/repo_transfer_dummy/;\
    npm install plotly-notebook-js;

WORKDIR $HOME/work/repo_transfer_dummy

EXPOSE 8888

USER $NB_UID