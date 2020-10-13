FROM nfcore/base:1.9
LABEL authors="Steffen Lemke" \
      description="Docker image containing all software requirements for the steffenlem/sradownloader pipeline"

# Install the conda environment
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/steffenlem-sradownloader-1.0.0/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name steffenlem-sradownloader-1.0.0 > steffenlem-sradownloader-1.0.0.yml
RUN mkdir -p .ncbi
RUN printf '/LIBS/GUID = "%s"\n' `uuid` > .ncbi/user-settings.mkfg
